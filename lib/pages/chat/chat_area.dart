// lib/pages/chat/chat_area.dart
import 'dart:async';
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';
import 'package:ConnectUs/services/ferry_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class ChatArea extends ConsumerStatefulWidget {
  final String userName;
  const ChatArea({super.key, required this.userName});

  @override
  ConsumerState<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends ConsumerState<ChatArea> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // User Info
  String? _myUsername;
  String? _myUserId;
  String? _targetUserId;

  // Status & Logic
  bool _isBlockedByMe = false;
  bool _isBlockedByThem = false;
  bool _isTargetOnline = false;

  // Subscription handlers
  supabase.RealtimeChannel? _statusChannel;
  StreamSubscription? _messageSubscription;

  // Local Storage (Hive — mobile only; web queries fresh each time)
  late Box _chatBox;

  bool get _isBlocked => _isBlockedByMe || _isBlockedByThem;

  /// Room ID derived from immutable user UUIDs (not usernames).
  /// Usernames can change; UUIDs cannot — using usernames orphans history on rename.
  String get _roomId {
    if (_myUserId == null || _targetUserId == null) return 'loading';
    final ids = [_myUserId!, _targetUserId!]..sort();
    return ids.join('_');
  }

  List<dynamic> get _localHistory =>
      kIsWeb ? [] : (_chatBox.get(_roomId, defaultValue: []) as List);

  void _saveToLocal(List<dynamic> messages) {
    if (!kIsWeb) _chatBox.put(_roomId, messages);
  }

  @override
  void initState() {
    super.initState();
    _chatBox = Hive.box('local_chats');
    _initializeChatSetup();
  }

  @override
  void dispose() {
    _statusChannel?.unsubscribe();
    _messageSubscription?.cancel();
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeChatSetup() async {
    final client = supabase.Supabase.instance.client;
    final user = client.auth.currentUser;
    if (user == null) return;

    _myUserId = user.id;

    // Get my username (used for display only — not for auth)
    final myData = await client
        .from('users')
        .select('usrname')
        .eq('id', user.id)
        .maybeSingle();

    // Get target user ID & online status from their username
    final targetData = await client
        .from('users')
        .select('id, is_online')
        .eq('usrname', widget.userName)
        .maybeSingle();

    if (mounted) {
      setState(() {
        _myUsername = myData?['usrname'] ?? 'Anonymous';
        if (targetData != null) {
          _targetUserId = targetData['id'];
          _isTargetOnline = targetData['is_online'] ?? false;
        }
      });

      if (_targetUserId != null) {
        await _checkBlockStatus();
        _startStatusSubscription();
        await _loadHistory();
        _startMessageSubscription();
      }
    }
  }

  // ── HISTORY LOADING ──────────────────────────────────────────────────────
  // All history comes from the GraphQL backend (which owns the Postgres table).
  // On mobile: incremental sync using the last cached message's timestamp.
  // On web: always fetches fresh (no local cache).
  Future<void> _loadHistory() async {
    if (_roomId == 'loading') return;
    try {
      final gqlClient = ref.read(clientProvider);

      String? after;
      if (!kIsWeb) {
        final cached = _localHistory;
        if (cached.isNotEmpty) {
          final last = cached.last;
          if (last is Map) after = last['createdAt'] as String?;
        }
      }

      final req = GFetchChatHistoryReq(
        (b) => b
          ..vars.roomId = _roomId
          ..vars.after = after,
      );

      await for (final response in gqlClient.request(req)) {
        if (response.data != null) {
          final messages = response.data!.messages
              .map((m) => {
                    'id': m.id,
                    'content': m.text,
                    'user': m.user,
                    'senderId': m.senderId,
                    'createdAt': m.createdAt,
                  })
              .toList();

          if (!kIsWeb && after != null) {
            // Incremental: append new messages to existing cache
            final existing = List<dynamic>.from(_localHistory);
            existing.addAll(messages);
            _saveToLocal(existing);
          } else {
            _saveToLocal(messages);
          }

          if (mounted) {
            setState(() {});
            _scrollToBottom();
          }
        }
        break; // query is one-shot
      }
    } catch (e) {
      debugPrint('Error loading history: $e');
    }
  }

  // ── STATUS (Supabase Realtime — still used for presence only) ────────────
  void _startStatusSubscription() {
    if (_targetUserId == null) return;
    final client = supabase.Supabase.instance.client;
    _statusChannel = client.channel('status:${_targetUserId}');
    _statusChannel!
        .onPostgresChanges(
          event: supabase.PostgresChangeEvent.update,
          schema: 'public',
          table: 'users',
          filter: supabase.PostgresChangeFilter(
            type: supabase.PostgresChangeFilterType.eq,
            column: 'id',
            value: _targetUserId!,
          ),
          callback: (payload) {
            if (payload.newRecord.containsKey('is_online') && mounted) {
              setState(() => _isTargetOnline = payload.newRecord['is_online']);
            }
          },
        )
        .subscribe();
  }

  // ── MESSAGE SUBSCRIPTION (GraphQL backend — room-scoped) ─────────────────
  void _startMessageSubscription() {
    if (_roomId == 'loading') return;
    final gqlClient = ref.read(clientProvider);
    final req = GListenToChatReq((b) => b..vars.roomId = _roomId);

    _messageSubscription = gqlClient.request(req).listen((response) {
      if (response.data != null) {
        final newMsg = response.data!.messages;
        // Skip messages we sent ourselves (already in local cache)
        if (newMsg.user != _myUsername) {
          final msgMap = {
            'id': newMsg.id,
            'content': newMsg.text,
            'user': newMsg.user,
            'senderId': newMsg.senderId,
            'createdAt': newMsg.createdAt,
          };
          final current = List<dynamic>.from(_localHistory);
          current.add(msgMap);
          _saveToLocal(current);
          if (mounted) {
            setState(() {});
            _scrollToBottom();
          }
        }
      }
    });
  }

  // ── BLOCKING ──────────────────────────────────────────────────────────────
  Future<void> _checkBlockStatus() async {
    if (_myUserId == null || _targetUserId == null) return;
    final client = supabase.Supabase.instance.client;
    final blockedByMe = await client
        .from('blocks')
        .select()
        .eq('blocker_id', _myUserId!)
        .eq('blocked_id', _targetUserId!)
        .maybeSingle();
    final blockedByThem = await client
        .from('blocks')
        .select()
        .eq('blocker_id', _targetUserId!)
        .eq('blocked_id', _myUserId!)
        .maybeSingle();
    if (mounted) {
      setState(() {
        _isBlockedByMe = blockedByMe != null;
        _isBlockedByThem = blockedByThem != null;
      });
    }
  }

  Future<void> _toggleBlock() async {
    if (_myUserId == null || _targetUserId == null) return;
    final client = supabase.Supabase.instance.client;
    try {
      if (_isBlockedByMe) {
        await client
            .from('blocks')
            .delete()
            .eq('blocker_id', _myUserId!)
            .eq('blocked_id', _targetUserId!);
        setState(() => _isBlockedByMe = false);
      } else {
        await client.from('blocks').insert({
          'blocker_id': _myUserId,
          'blocked_id': _targetUserId,
        });
        setState(() => _isBlockedByMe = true);
      }
    } catch (e) {
      debugPrint('Block error: $e');
    }
  }

  // ── SEND ──────────────────────────────────────────────────────────────────
  void _sendChat() {
    if (_isBlocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You cannot message this user.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_controller.text.trim().isEmpty || _myUsername == null) return;
    if (_roomId == 'loading') return;

    final text = _controller.text;
    _controller.clear();

    // Optimistic local update so the sender sees their message instantly
    final msgMap = {
      'content': text,
      'user': _myUsername,
      'senderId': _myUserId,
      'createdAt': DateTime.now().toIso8601String(),
    };
    final current = List<dynamic>.from(_localHistory);
    current.add(msgMap);
    _saveToLocal(current);
    setState(() {});
    _scrollToBottom();

    // Send via GraphQL — single write path, no Supabase upsert
    final gqlClient = ref.read(clientProvider);
    final req = GsendMessageReq((b) => b
      ..vars.roomId = _roomId
      ..vars.text = text);

    gqlClient.request(req).first.then((response) {
      if (response.hasErrors) {
        debugPrint('Send error: ${response.graphqlErrors}');
      }
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  Color get _statusColor {
    if (_isBlocked) return Colors.red;
    if (_isTargetOnline) return Colors.green;
    return Colors.blue;
  }

  String get _statusText {
    if (_isBlocked) return 'Blocked';
    if (_isTargetOnline) return 'Online';
    return 'Offline';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.accentDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _statusColor, width: 2.5),
              ),
              child: const CircleAvatar(
                backgroundColor: AppTheme.accent,
                radius: 18,
                child: Icon(Icons.person, color: Colors.black, size: 20),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _statusText,
                  style: TextStyle(
                    color: _statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              if (value == 'block') _toggleBlock();
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'block',
                child: Text(_isBlockedByMe ? 'Unblock User' : 'Block User'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _localHistory.length,
              itemBuilder: (context, index) {
                final rawMsg = _localHistory[index];
                final content =
                    rawMsg is Map ? (rawMsg['content'] as String? ?? '') : '';
                final user =
                    rawMsg is Map ? (rawMsg['user'] as String? ?? '') : '';
                return _buildMessageBubble(content, user == _myUsername, user);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String content, bool isMe, String user) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blueGrey[800] : AppTheme.accentDark,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isMe ? const Radius.circular(12) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(12),
          ),
        ),
        child: Text(
          content,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.black12,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              enabled: !_isBlocked,
              onSubmitted: (_) => _sendChat(),
              onChanged: (_) => setState(() {}),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: _isBlocked
                    ? 'You cannot reply to this conversation'
                    : 'Type a message...',
                hintStyle: TextStyle(
                  color: _isBlocked
                      ? Colors.redAccent
                      : AppTheme.hint.withAlpha(128),
                ),
                filled: true,
                fillColor: Colors.white.withAlpha(13),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: _isBlocked ? Colors.grey : AppTheme.accent,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.black),
              onPressed: _isBlocked ? null : _sendChat,
            ),
          ),
        ],
      ),
    );
  }
}
