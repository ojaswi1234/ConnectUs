import 'dotenv/config';
import express from 'express';
import { createYoga, createSchema, createPubSub } from 'graphql-yoga';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { useServer } from 'graphql-ws/use/ws';
import pkg from 'pg';
import { createClient } from '@supabase/supabase-js';
import jwt from 'jsonwebtoken';

const { Pool } = pkg;

// ─── DATABASE ────────────────────────────────────────────────────────────────
// All chat message reads/writes go through this connection.
// Supabase is used ONLY for user lookup (usrname, phone_number, is_online).
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false },
});

// ─── SUPABASE (user table only) ──────────────────────────────────────────────
const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

// ─── PUBSUB ──────────────────────────────────────────────────────────────────
const pubsub = createPubSub();

// ─── RATE LIMITER (search) ───────────────────────────────────────────────────
// Simple in-memory: 30 searches per userId per minute.
const searchRateLimits = new Map();
function checkSearchRateLimit(userId) {
  const now = Date.now();
  const entry = searchRateLimits.get(userId);
  if (!entry || now > entry.resetAt) {
    searchRateLimits.set(userId, { count: 1, resetAt: now + 60_000 });
    return true;
  }
  if (entry.count >= 30) {
    console.warn(`[RATE_LIMIT] userId=${userId} exceeded search limit`);
    return false;
  }
  entry.count++;
  return true;
}

// ─── AUTH HELPER ─────────────────────────────────────────────────────────────
async function getAuthContext(headers, connectionParams) {
  const raw =
    headers?.get?.('authorization') ||
    connectionParams?.Authorization ||
    connectionParams?.authorization;
  if (!raw || !raw.startsWith('Bearer ')) return null;
  const token = raw.slice(7);
  try {
    const secret = process.env.SUPABASE_JWT_SECRET;
    if (!secret) throw new Error('SUPABASE_JWT_SECRET not configured');
    const decoded = jwt.verify(token, secret);
    return { userId: decoded.sub };
  } catch (e) {
    console.warn('[AUTH] JWT verify failed:', e.message);
    return null;
  }
}

function requireAuth(ctx) {
  if (!ctx || !ctx.userId) {
    throw new Error('Unauthorized: valid JWT required');
  }
}

// ─── SCHEMA ──────────────────────────────────────────────────────────────────
// IMPORTANT: Keep in sync with lib/graphql/schema.graphql in the Flutter client.
// After any change here, run: flutter pub run build_runner build --delete-conflicting-outputs
const typeDefs = `
  type Message {
    id: ID!
    roomId: String!
    senderId: String!
    user: String!
    text: String!
    createdAt: String!
  }

  enum Platform { MOBILE WEB }

  type UserSearchResult {
    id: ID!
    username: String!
    phoneNumber: String
    isOnline: Boolean!
  }

  enum CallSignalType { OFFER ANSWER ICE_CANDIDATE HANGUP }

  type CallSignal {
    roomId: String!
    senderId: String!
    type: CallSignalType!
    payload: String!
  }

  type Query {
    messages(roomId: String!, after: String): [Message!]!
    searchUsers(query: String!, platform: Platform!): [UserSearchResult!]!
  }

  type Mutation {
    postMessage(roomId: String!, user: String!, text: String!): Message!
    sendCallSignal(roomId: String!, type: CallSignalType!, payload: String!): Boolean!
    askAssistant(prompt: String!): String!
  }

  type Subscription {
    messages(roomId: String!): Message!
    callSignals(roomId: String!): CallSignal!
  }
`;

// ─── RESOLVERS ───────────────────────────────────────────────────────────────
const resolvers = {
  Query: {
    messages: async (_, { roomId, after }, ctx) => {
      requireAuth(ctx);
      let queryText = 'SELECT * FROM chat_messages WHERE room_id = $1';
      const params = [roomId];
      if (after) {
        queryText += ' AND created_at > $2';
        params.push(after);
      }
      queryText += ' ORDER BY created_at ASC LIMIT 200';
      const { rows } = await pool.query(queryText, params);
      return rows.map(r => ({
        id: r.id,
        roomId: r.room_id,
        senderId: r.sender_id,
        user: r.sender_username,
        text: r.content,
        createdAt: r.created_at.toISOString(),
      }));
    },

    searchUsers: async (_, { query, platform }, ctx) => {
      requireAuth(ctx);
      if (!checkSearchRateLimit(ctx.userId)) {
        throw new Error('Rate limit exceeded. Try again in a minute.');
      }
      console.log(`[SEARCH] userId=${ctx.userId} query="${query}" platform=${platform}`);
      const { data, error } = await supabase
        .from('users')
        .select('id, usrname, phone_number, is_online')
        .ilike('usrname', `%${query}%`)
        .limit(20);
      if (error) throw new Error(error.message);
      return (data || []).map(u => ({
        id: u.id,
        username: u.usrname,
        // SECURITY: phoneNumber is NEVER returned for WEB requests — server enforced.
        phoneNumber: platform === 'MOBILE' ? u.phone_number : null,
        isOnline: u.is_online ?? false,
      }));
    },
  },

  Mutation: {
    postMessage: async (_, { roomId, text }, ctx) => {
      requireAuth(ctx);
      // Look up the canonical username server-side — ignore the user arg the client sends.
      // This prevents a client from impersonating another user.
      const { data: userData, error: userErr } = await supabase
        .from('users')
        .select('usrname')
        .eq('id', ctx.userId)
        .maybeSingle();
      if (userErr || !userData) throw new Error('User not found');
      const username = userData.usrname;

      const { rows } = await pool.query(
        `INSERT INTO chat_messages (room_id, sender_id, sender_username, content)
         VALUES ($1, $2, $3, $4) RETURNING *`,
        [roomId, ctx.userId, username, text]
      );
      const row = rows[0];
      const message = {
        id: row.id,
        roomId: row.room_id,
        senderId: row.sender_id,
        user: row.sender_username,
        text: row.content,
        createdAt: row.created_at.toISOString(),
      };
      // Publish to per-room topic only — not a global broadcast.
      pubsub.publish(`MSG_UPDATE:${roomId}`, message);
      return message;
    },

    sendCallSignal: async (_, { roomId, type, payload }, ctx) => {
      requireAuth(ctx);
      pubsub.publish(`CALL_${roomId}`, {
        roomId,
        senderId: ctx.userId,
        type,
        payload,
      });
      return true;
    },

    askAssistant: async (_, { prompt }, ctx) => {
      requireAuth(ctx);
      const groqKey = process.env.GROQ_API_KEY;
      if (!groqKey) throw new Error('AI assistant not configured on this server.');
      const resp = await fetch('https://api.groq.com/openai/v1/chat/completions', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${groqKey}`,
        },
        body: JSON.stringify({
          model: 'llama-3.3-70b-versatile',
          messages: [
            {
              role: 'system',
              content:
                'You are Connectify, the assistant for the ConnectUs chat app. Be helpful and concise.',
            },
            { role: 'user', content: prompt },
          ],
          max_tokens: 1024,
        }),
      });
      const json = await resp.json();
      if (!resp.ok) throw new Error(json.error?.message || 'Groq API error');
      return json.choices[0].message.content;
    },
  },

  Subscription: {
    messages: {
      subscribe: (_, { roomId }, ctx) => {
        requireAuth(ctx);
        return pubsub.subscribe(`MSG_UPDATE:${roomId}`);
      },
      resolve: (payload) => payload,
    },
    callSignals: {
      subscribe: (_, { roomId }, ctx) => {
        requireAuth(ctx);
        return pubsub.subscribe(`CALL_${roomId}`);
      },
      resolve: (payload) => payload,
    },
  },
};

// ─── CONTEXT BUILDER ─────────────────────────────────────────────────────────
async function buildContext({ request }) {
  if (request) {
    const ctx = await getAuthContext(request.headers, {});
    return ctx || {};
  }
  return {};
}

// ─── SERVER ──────────────────────────────────────────────────────────────────
const schema = createSchema({ typeDefs, resolvers });
const app = express();
const httpServer = createServer(app);

const yoga = createYoga({
  schema,
  context: buildContext,
  graphqlEndpoint: '/graphql',
  graphiql: { subscriptionsProtocol: 'WS' },
});

const wsServer = new WebSocketServer({
  server: httpServer,
  path: yoga.graphqlEndpoint,
});

useServer(
  {
    schema,
    context: async (ctx) => {
      const auth = await getAuthContext(null, ctx.connectionParams || {});
      return auth || {};
    },
  },
  wsServer
);

app.use(yoga.graphqlEndpoint, yoga);

// ─── DB MIGRATIONS (run on startup) ─────────────────────────────────────────
async function runMigrations() {
  try {
    await pool.query(`
      CREATE TABLE IF NOT EXISTS chat_messages (
        id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
        room_id TEXT NOT NULL,
        sender_id uuid NOT NULL,
        sender_username TEXT NOT NULL,
        content TEXT NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT now()
      );
      CREATE INDEX IF NOT EXISTS idx_chat_messages_room_time
        ON chat_messages (room_id, created_at);
    `);
    console.log('[DB] Migrations applied.');
  } catch (e) {
    console.error('[DB] Migration failed (DATABASE_URL not set?):', e.message);
  }
}

const PORT = process.env.PORT || 3000;
httpServer.listen(PORT, async () => {
  await runMigrations();
  console.log(`🚀 ConnectUs Backend → http://localhost:${PORT}/graphql`);
});