# ConnectUs — Diagnostic & Fix Brief for Gemini CLI (v2)

This replaces the earlier draft. Key change: **Phase 2 now goes with Path B** — the custom
GraphQL backend is fixed and made the real-time backbone (not Supabase Realtime), to keep
the app's messaging layer independent of Supabase as a platform. Supabase is kept, but
demoted to: Auth, the `users` table, presence/blocks, and (via the backend's own DB
connection, not the client SDK) the durable Postgres store the GraphQL layer reads/writes.

Two new sections were added to capture your platform split:
- **Phase 2A** — search: phone-number-first on mobile, username-only on web
- **Phase 2B** — storage: durable backend store as single source of truth, Hive as
  offline cache, real-time sync between mobile and web through GraphQL subscriptions

Per your note, **Phase 4 (mechanical bug fixes)** and **Phases 5–6 (calling + AI)** are
where you want the most attention — expanded with concrete acceptance checks.

**How to use this file:**
```
gemini --prompt "Read CONNECTUS_GEMINI_FIX_PLAN_V2.md and execute Phase 0 first.
Then stop and show me a diff/summary before continuing to Phase 1."
```
Work phase-by-phase, commit after each. Phases 2/2A/2B are interdependent and should be
done together since they all touch `chat_area.dart`, `backend/server.js`, and the GraphQL
schema/codegen in the same pass — don't split those three across separate sessions or the
codegen will be out of sync mid-way.

---

## Phase 0 — Safety net

1. `git checkout -b fix/graphql-backend-and-bugs`
2. Save a baseline: `flutter analyze > analyze_baseline.txt`
3. `flutter test` baseline too — note any pre-existing failures so you don't chase ghosts later.

**Acceptance:** branch exists, baselines saved.

---

## Phase 1 — Security fixes that don't depend on the architecture decision

These are independent of Phase 2 and safe to do first.

### 1.1 — Fix or remove the fake encryption
`lib/services/security_services.dart` uses a hardcoded static key and a **zero-filled
static IV** (`encrypt.IV.fromLength(16)`), and `chat_area.dart::_sendChat()` never actually
calls `encryptMessage()` before persisting — so today it's dead code giving a false sense
of security.

- **Minimum fix (do this regardless):** if you keep `SecurityService` at all, generate a
  random IV per message (`encrypt.IV.fromSecureRandom(16)`) and prepend it to the
  ciphertext so the receiver can read it back out. A static/shared IV is never acceptable
  even with a real key.
- Decide: either wire it into the real send/receive path (per-conversation keys via key
  exchange, stored with `flutter_secure_storage`), or remove it and be explicit in the UI
  that messages aren't E2E encrypted. Don't ship it half-wired as it is now.

**Acceptance:** sending the same plaintext twice produces different ciphertext.

### 1.2 — Stop bundling secrets into the app binary
`pubspec.yaml` lists `assets/.env` as a Flutter asset — every release build ships the
Supabase keys and the **Groq API key** inside the package, extractable by unzipping it.

- Remove `assets/.env` from `flutter: assets:`.
- Switch to `--dart-define-from-file` for build-time injection.
- Move the Groq call behind a tiny server-side proxy (see Phase 6.2 — this matters more now
  since the GraphQL backend already exists and is the natural place to host it).

**Acceptance:** `unzip -l <release-build> | grep -i ".env"` returns nothing; no Groq key string found via `strings` on the release binary.

---

## Phase 2 — GraphQL backend: fix the schema mismatch and make it the real-time backbone

**Problem recap:** the client sends `sendMessage($user, $text, $roomId)` but the deployed
schema's `postMessage(user, text)` has no `roomId` argument, so the mutation is rejected by
GraphQL validation every time. The `Subscription.messages` resolver also returns the
**entire unscoped** in-memory array to every subscriber, with no room filtering, no
persistence, and no auth.

### 2.1 — Fix the schema (server + client codegen together)

`backend/server.js` typeDefs:
```graphql
type Message {
  id: ID!
  roomId: String!
  senderId: String!
  user: String!
  text: String!
  createdAt: String!
}

type Query {
  messages(roomId: String!, after: String): [Message!]!
}

type Mutation {
  postMessage(roomId: String!, user: String!, text: String!): Message!
}

type Subscription {
  messages(roomId: String!): Message!
}
```

Resolvers:
- `Query.messages(roomId, after)` → reads from the durable store (Phase 2B), filtered by
  `roomId`, optionally only rows newer than `after` (an ISO timestamp or cursor) so clients
  can do incremental resync instead of always pulling full history.
- `Mutation.postMessage` → inserts a row into the durable store, then
  `pubsub.publish(\`MSG_UPDATE:${roomId}\`, message)` — **a per-room topic, not the single
  global topic it uses today.**
- `Subscription.messages(roomId)` → `pubsub.subscribe(\`MSG_UPDATE:${roomId}\`)`, scoped to
  that room only.

Update `lib/graphql/operations.graphql` to match (add `roomId`/`after` args, request the new
fields), then regenerate: `flutter pub run build_runner build --delete-conflicting-outputs`.
Update `lib/graphql/schema.graphql` to mirror the server's actual schema exactly — this file
drifting from the deployed server is exactly what caused the original bug, so add a comment
at the top of `schema.graphql` noting it must be regenerated from the live server (`gql
codegen` / introspection) whenever `server.js`'s typeDefs change, not hand-edited.

**Acceptance:** sending a message in room A is never delivered to a subscriber on room B
(test with two simulators in two different conversations). The mutation no longer returns a
GraphQL validation error.

### 2.2 — Auth on the GraphQL backend

Right now anyone can call `postMessage` as any `user` string with no credentials.

- Attach the Supabase access token as a Bearer header on every GraphQL request — add an
  `AuthLink`/custom `Link` in `ferry_client.dart` that reads
  `Supabase.instance.client.auth.currentSession?.accessToken` and sets the
  `Authorization: Bearer <token>` header on outgoing requests (HTTP and WS both — `graphql-ws`
  supports passing `connectionParams` for the WS handshake).
- Server-side: verify the JWT against Supabase's JWKS endpoint
  (`https://<project>.supabase.co/auth/v1/.well-known/jwks.json`) or the project's JWT
  secret, extract the verified `sub` (user id), and **derive `senderId` from the verified
  token — never trust the client-supplied value for who sent it.** Look up the display
  `user`/username server-side from the `users` table using `senderId`, ignoring any
  mismatched `user` argument the client sends (or reject the request if it disagrees — more
  defensive).
- Reject any request without a valid token with a `401`/GraphQL auth error before it reaches a resolver.

**Acceptance:** an unauthenticated `curl` POST to `/graphql` calling `postMessage` is
rejected. A request with a valid token for user A cannot make messages appear to be sent
"as" user B.

### 2.3 — Real-time sync between mobile and web (the actual point of Phase 2)

Because both platforms will now share the same `ferry` client code, the same backend, and
the same room-scoped subscription, this naturally gives you what you asked for: **whoever
sends a message, both platforms see it live**, because both are subscribed to
`messages(roomId: <same id>)` against the same backend regardless of which platform wrote it.

In `chat_area.dart`:
- Replace `_startMessageSubscription()`'s listener so it subscribes to
  `GListenToChatReq` parameterized with `_roomId` (not the old unscoped one).
- `_sendChat()` should call the (now-working) `postMessage` mutation as the **single write
  path** for delivering the message to the other party in real time. Local Hive/Postgres
  writes (Phase 2B) become persistence concerns, decoupled from delivery.

**Acceptance:** open the same conversation on a mobile build and a web build simultaneously
(two separate sessions, two different user accounts). A message sent from either side
appears on the other within ~1s without a manual refresh.

---

## Phase 2A — Platform-specific contact search

Your split:
- **Mobile:** search primarily by phone number (so relatives can find each other without
  needing to know a username), with username as an additional/optional matched field.
- **Web:** username only — phone numbers must never be exposed on the web build.

### Implementation

The important realization: **Supabase RLS policies can't distinguish "this request came
from the mobile build" vs "the web build"** — both use the same anon key and the same
table. If you want the platform split to be actually enforced (not just "the web UI happens
not to ask for it, but a curious user could open devtools and call Supabase directly with
the same query mobile uses"), the search needs to go through something that *does* know
which platform is asking — i.e. the GraphQL backend you're already keeping.

**Recommended fix — route contact search through the GraphQL backend, not the Supabase client directly:**

```graphql
type UserSearchResult {
  id: ID!
  username: String!
  phoneNumber: String   # only ever populated for mobile-platform requests
  isOnline: Boolean!
}

enum Platform { MOBILE WEB }

type Query {
  searchUsers(query: String!, platform: Platform!): [UserSearchResult!]!
}
```

Resolver logic:
- `platform: MOBILE` → match against `usrname ILIKE` **or** `phone_number = <normalized query>`,
  return both fields.
- `platform: WEB` → match against `usrname ILIKE` only, and **never select/return
  `phone_number`** regardless of what the caller asks for — hardcode the field omission in
  the resolver, don't make it conditional purely on a client-supplied flag (a client could
  lie about its own platform; at minimum log/rate-limit this query so bulk phone-number
  harvesting attempts are visible even if not perfectly preventable from a public API).
- Client passes `Platform.MOBILE` / `Platform.WEB` based on `kIsWeb`/`Platform.isAndroid`
  checks already present in `contacts_page.dart` — reuse the existing `isMobile` getter.

### Mobile-side query normalization
Phone numbers typed into the search box, or pulled from the device's `flutter_contacts`
address book, need normalizing before matching against the stored `+91XXXXXXXXXX` format
(strip spaces/dashes/parens, handle a leading `0` or missing country code) — add a small
`normalizePhone(String raw)` util in `lib/utils/` and use it both at registration time
(`register_phone.dart`) and at search time so the formats always line up.

**Acceptance:** a web session searching `"johnsphone"` or a raw phone number never receives
a `phoneNumber` field in the response, even if it knows another user's exact phone number to
search for. A mobile session searching a phone number from the device address book finds a
match. A mobile session searching a partial username also finds a match.

---

## Phase 2B — Storage architecture: durable backend store + local cache, kept in sync

Your current setup has Supabase as the durable store for web reload and as an ad-hoc
"fallback resync" for missed messages, with mobile relying on local Hive only. Folding chat
storage into the backend (Phase 2) gives you one durable store usable by both platforms
instead of the current asymmetric setup, while keeping Hive as a genuinely useful offline
cache on mobile.

### 2B.1 — One durable table, one row per message (not one blob per room)

```sql
create table if not exists chat_messages (
  id uuid primary key default gen_random_uuid(),
  room_id text not null,
  sender_id uuid not null,
  sender_username text not null,
  content text not null,
  created_at timestamptz not null default now()
);
create index if not exists idx_chat_messages_room_time on chat_messages (room_id, created_at);
```

This can live in the same Supabase Postgres instance you already have — but the GraphQL
**backend connects to it directly via a Postgres connection string** (e.g. `pg` or
`postgres.js`, using the database's connection pooler, with credentials kept server-side
only), not via the Supabase client SDK from the Flutter app. That's what keeps the app's
messaging path "independent" of Supabase as a platform dependency, while you still get to
reuse the database you already provisioned instead of standing up a second one.

Migrate the existing `messages` table (one JSON blob per room) into this new table with a
one-time script, then stop writing to the old table.

### 2B.2 — Remove the full-history-overwrite pattern

`_updateHistoryInSupabase()` currently upserts the *entire* message array on every send —
this is what caused the race condition (two near-simultaneous senders silently drop each
other's messages). Once `postMessage` (2.1) does a single-row insert against
`chat_messages`, delete `_updateHistoryInSupabase()` and `_fetchHistoryFromSupabase()`
entirely — replace both with:
- On chat open: `GFetchChatHistoryReq` parameterized with `roomId` (and optionally an
  `after` cursor for incremental loads), via the GraphQL client → backend → `chat_messages`.
- On send: `postMessage` mutation only.

### 2B.3 — Hive's new job: offline cache, not source of truth

- Keep `_chatBox` on mobile, but it's now populated *from* GraphQL responses (history query
  + subscription pushes), not the other way around. On reconnect after being offline,
  re-run the history query with `after: <timestamp of last cached message>` to backfill any
  gaps — this is the proper version of the "fallback resync" role `_updateHistoryInSupabase`
  was informally playing.
- Optional stretch goal (mention to the user, don't block on it): an outbox queue in Hive
  for messages composed while offline, flushed via `postMessage` once connectivity returns.
- Web can use the same query/subscription pattern without needing a local cache at all
  (always fetch fresh on open) — or keep a lightweight IndexedDB-backed Hive cache if you
  want faster repeat opens; it's not required for correctness like it is for mobile offline use.

**Acceptance:** kill the network mid-conversation on mobile, send a few messages (queued or
visibly failed, your choice per the stretch goal), restore network — verify no message gets
silently lost and the room never gets overwritten/truncated. Logging into the web build
after a mobile conversation shows full history immediately.

---

## Phase 3 — Contact-search privacy guard (tightened version of the earlier note)

This is now mostly handled by routing search through the backend (2A), which is the right
enforcement point. One remaining client-side cleanup:

- In `lib/pages/contacts_page.dart`, remove the direct
  `Supabase.instance.client.from('users').select('usrname, phone_number')...` call in
  `_searchUsersOnWeb()` entirely and replace it with the new `searchUsers(query, platform)`
  GraphQL query from 2A, for both the mobile and web code paths (just with a different
  `platform` argument) — don't keep two separate search implementations in the client.

**Acceptance:** `grep -rn "from('users').select" lib/pages/contacts_page.dart` returns nothing.

---

## Phase 4 — Mechanical bug fixes (your priority — batch these in one pass)

Independent, low-risk, good for a single Gemini CLI batch with `flutter analyze` after.

| # | File | Problem | Fix |
|---|------|---------|-----|
| 4.1 | `lib/pages/ai_page.dart` | `onSubmitted: (_) => _handleSend` passes the function reference instead of calling it — Enter key does nothing | `onSubmitted: (_) => _handleSend()` |
| 4.2 | `lib/pages/ai_page.dart` | Send button's enabled state doesn't update live while typing | Add `onChanged: (_) => setState(() {})` to the `TextField`, or wrap the send icon in a `ValueListenableBuilder` keyed on `_textController` |
| 4.3 | `lib/pages/auth/register_phone.dart` | Validator accepts non-digit 10-character strings | `if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) return 'Enter a valid 10-digit number';` — and reuse the `normalizePhone()` util from Phase 2A here too, so registration and search always agree on format |
| 4.4 | `lib/pages/auth/login.dart` | `password: _password.trim()` strips intentional whitespace | Remove `.trim()` on the password value (keep it on email) |
| 4.5 | `lib/services/AuthChecker.dart` | `onAuthStateChange.listen(...)` subscription never stored/cancelled — leaks listeners on rebuild | Store the `StreamSubscription` in a field; cancel in `dispose()`; guard against double-subscribing if `initState` runs again |
| 4.6 | `lib/main.dart` | `/contacts` named route registered with no-op callbacks, unreachable in any useful way | Remove the named route, or wire real navigation/callbacks if it's actually used somewhere via `pushNamed('/contacts')` — `grep -rn "pushNamed('/contacts'" lib/` first to check if it's dead code |
| 4.7 | Various screens | Raw `e.toString()` shown in `SnackBar`s, leaking internals | Catch `AuthException`/`PostgrestException` (and now GraphQL errors from the backend) and map to friendly copy; log the raw exception via `Logger` instead of displaying it |
| 4.8 | `pubspec.yaml` | `langchain_ollama` declared but unused | Confirm with `grep -rn "langchain_ollama" lib/`, then remove the dependency line |

**Acceptance:** `flutter analyze` clean; manual pass confirms Enter sends AI messages,
garbage phone numbers rejected, no duplicate auth listeners after repeated sign-out/sign-in
cycles.

---

## Phase 5 — Calling: replace the mockup with a real flutter_webrtc flow (your priority)

`video.dart`/`voice.dart` are currently static UI shells — every control except "end call"
has an empty `onPressed`. `flutter_webrtc` is a declared dependency but unused anywhere.
No `CAMERA`/`RECORD_AUDIO` permissions exist in the manifest.

Since you're keeping the GraphQL backend as the app's real-time backbone, **use it for call
signaling too** — same one-and-only real-time channel, no second dependency on Supabase
Realtime for this either.

### 5.1 — Permissions
`android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS"/>
```
`ios/Runner/Info.plist`: add `NSCameraUsageDescription` and `NSMicrophoneUsageDescription`.
Request these at runtime via `permission_handler` (already a dependency) before touching
`getUserMedia`.

### 5.2 — Signaling schema (add to the same GraphQL backend, Phase 2's schema)
```graphql
type CallSignal {
  roomId: String!
  senderId: String!
  type: CallSignalType!
  payload: String!   # JSON-encoded SDP or ICE candidate
}
enum CallSignalType { OFFER ANSWER ICE_CANDIDATE HANGUP }

type Mutation {
  sendCallSignal(roomId: String!, type: CallSignalType!, payload: String!): Boolean!
}
type Subscription {
  callSignals(roomId: String!): CallSignal!
}
```
This reuses the exact same per-room pubsub-topic pattern from Phase 2.1
(`pubsub.publish(\`CALL_${roomId}\`, signal)`), no new infrastructure.

### 5.3 — Peer connection flow in `video.dart`/`voice.dart`
- STUN server minimum (`stun:stun.l.google.com:19302`); note TURN as a known future gap for
  NAT-restrictive networks, don't block MVP on it.
- `getUserMedia` → local `RTCVideoRenderer` (skip for voice-only calls).
- Caller: create offer → `sendCallSignal(type: OFFER, ...)`.
- Callee: on receiving `OFFER` via subscription → create answer → `sendCallSignal(type: ANSWER, ...)`.
- Both sides: exchange `ICE_CANDIDATE` signals as `onIceCandidate` fires.
- Wire every existing UI button to real state: mute → toggle local audio track `.enabled`;
  camera off → toggle local video track `.enabled`; camera flip → `mediaStreamTrack.switchCamera()`;
  end call → send `HANGUP` signal + `peerConnection.close()` + `Navigator.pop`.

### 5.4 — Incoming call handling
There's currently no way for the callee to know a call is happening unless they're already
on the matching `ChatArea` screen. Add a top-level listener (registered once, e.g. in `Home`
or a Riverpod provider scoped above the navigator) subscribed to call signals addressed to
the current user across all rooms, which surfaces a full-screen incoming-call UI with
accept/decline regardless of what screen they're currently on.

**Acceptance:** two devices on the same network can place and receive a call; mute, camera
toggle, and end-call buttons all have an observable effect; a call arriving while the callee
is on an unrelated screen (e.g. Home) still surfaces an incoming-call prompt.

---

## Phase 6 — AI assistant section (your priority)

### 6.1 — Fix the immediate bugs (cross-ref 4.1/4.2 above — same file, do together)

### 6.2 — Move the Groq key off the device
Since the GraphQL backend already exists and now holds your DB credentials and JWT
verification logic, it's the natural home for this too:
```graphql
type Mutation {
  askAssistant(prompt: String!): String!   # or a Subscription for streaming chunks
}
```
- `ai_page.dart` calls this mutation/subscription instead of hitting `api.groq.com`
  directly with a client-held key.
- Backend holds `GROQ_API_KEY` as a server environment variable, never sent to any client.
- If you want streaming responses (the current UI does word-by-word streaming via
  `chain.stream(...)`), use a GraphQL `Subscription` that emits chunks as they arrive from
  Groq, or fall back to Server-Sent Events on a plain Express route if you'd rather not
  model streaming as a GraphQL subscription.
- Add basic rate-limiting per authenticated user on this resolver — an unmetered AI proxy
  behind your own backend is exactly as exploitable as a leaked key if anyone can call it
  unlimited times.

**Acceptance:** `grep -rn "GROQ_API_KEY\|api.groq.com" lib/` returns nothing in the Flutter
app; the AI page still works end-to-end through the new backend route, including streaming.

---

## Suggested session order for Gemini CLI

1. Phase 0
2. Phase 1 (security, no architecture decisions needed)
3. **Phase 2 + 2A + 2B together** (interdependent — schema, search, storage all touch the
   same backend file and the same `chat_area.dart`/`contacts_page.dart` in one coherent pass)
4. Phase 3 (small cleanup, depends on 2A landing first)
5. Phase 4 (bug-fix batch)
6. Phase 5 (calling)
7. Phase 6 (AI)

After each phase, have Gemini CLI summarize files changed and flag anything needing manual
device/simulator testing (it can't run the actual call flow or multi-device sync test
itself — those need a human with two devices/sessions).
