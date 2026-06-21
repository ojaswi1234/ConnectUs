// lib/pages/chat/chatArea.dart
import 'dart:async';
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';
import 'package:ConnectUs/services/ferry_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:ConnectUs/services/security_services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:ConnectUs/providers/call_provider.dart';
import 'package:ConnectUs/pages/chat/voice.dart';
import 'package:ConnectUs/pages/chat/video.dart';
import 'package:ConnectUs/services/chat_sync_service.dart';

class ChatArea extends ConsumerStatefulWidget {
  final String userName;
  final String? supabaseUsername;
  final Function(String message, DateTime time)? onMessageSent;

  const ChatArea({super.key, required this.userName, this.supabaseUsername, this.onMessageSent});

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
  Timer? _blockPoller;
  supabase.RealtimeChannel? _blockChannel;
  Timer? _statusRetryTimer;        // ADD
  Timer? _offlinePollTimer;       // ADD
  StreamSubscription? _syncSubscription;

  // Local Storage
  late Box _chatBox;

  // Computed Property for "Are we blocked?"
  bool get _isBlocked => _isBlockedByMe || _isBlockedByThem;

  @override
  void initState() {
    super.initState();
    // Ensure 'local_chats' box is open (done in main.dart)
    _chatBox = Hive.box('local_chats');
    _initializeChatSetup();
    _startBlockStatusPoller();
    _updateMyRoomPresence(true); // ENTER room
    _startOfflinePolling();        // ADD

    // Listen to global sync for this room
    _syncSubscription = ChatSyncService().messageStream.listen((event) {
      if (event['room_id'] == _roomId && mounted) {
        final messages = event['messages'] as List;
        _saveToLocal(messages);
        setState(() {});
        _scrollToBottom();
      }
    });
  }

  void _startBlockStatusPoller() {
    _blockPoller = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted && _targetUserId != null) {
        _checkBlockStatus();
      }
    });
  }

  @override
  void dispose() {
    _updateMyRoomPresence(false); // LEAVE room
    
    // ADD: Cancel all timers first
    _statusRetryTimer?.cancel();
    _offlinePollTimer?.cancel();
    _syncSubscription?.cancel(); // ADD
    
    // ADD: Fully remove channel from client, not just unsubscribe
    if (_statusChannel != null) {
      supabase.Supabase.instance.client.removeChannel(_statusChannel!);
    }
    if (_blockChannel != null) {
      supabase.Supabase.instance.client.removeChannel(_blockChannel!);
    }
    
    _messageSubscription?.cancel();
    _blockPoller?.cancel();
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _updateMyRoomPresence(bool isInRoom) async {
    if (_myUserId == null) return;
    try {
      await supabase.Supabase.instance.client
          .from('users')
          .update({'current_room': isInRoom ? _roomId : null})
          .eq('id', _myUserId!);
    } catch (e) {
      debugPrint('Error updating room presence: $e');
    }
  }

  Future<void> _initializeChatSetup() async {
    final client = supabase.Supabase.instance.client;
    final user = client.auth.currentUser;

    if (user != null) {
      _myUserId = user.id;

      // 1. Get My Username
      final myData = await client
          .from('users')
          .select('usrname')
          .eq('id', user.id)
          .maybeSingle();

      // 2. Get Target User ID & Status from their Username
      final lookupName = widget.supabaseUsername ?? widget.userName;
      final targetData = await client
          .from('users')
          .select('id, is_online')
          .eq('usrname', lookupName)
          .maybeSingle();

      if (mounted) {
        setState(() {
          _myUsername = myData?['usrname'] ?? 'Anonymous';
          if (targetData != null) {
            _targetUserId = targetData['id'];
            _isTargetOnline = targetData['is_online'] ?? false;
          }
        });

        // 3. Start Subscriptions if we found the target user
        if (_targetUserId != null) {
          await _checkBlockStatus();
          await _fetchHistoryFromSupabase(); // Load old messages
          _startStatusSubscription();
          _startMessageSubscription();
          _startBlockSubscription();
        }
      }
    }
  }

  // --- NEW: FETCH AND UPDATE SUPABASE HISTORY ---

  // Fetch the full message history from Supabase when the chat opens
  Future<void> _fetchHistoryFromSupabase() async {
    if (_roomId == "loading") return;
    try {
      final client = supabase.Supabase.instance.client;
      final response = await client
          .from('messages')
          .select('messages')
          .eq('room_id', _roomId)
          .maybeSingle();

      if (response != null && response['messages'] != null) {
        final remoteMessages = List.from(response['messages']);
        final localMessages = List.from(_localHistory);

        // Merge: deduplicate
        final localKeys = localMessages.map((m) => '${m['user']}:${m['content']}:${m['createdAt']}').toSet();
        final newOnes = remoteMessages.where((m) {
          final key = '${m['user']}:${m['content']}:${m['createdAt']}';
          return !localKeys.contains(key);
        }).toList();

        if (newOnes.isNotEmpty) {
          final merged = [...localMessages, ...newOnes];
          _saveToLocal(merged);
          if (mounted) {
            setState(() {});
            _scrollToBottom();
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching history from Supabase: $e");
    }
  }

  // Update (or insert) the message history in Supabase
  Future<void> _updateHistoryInSupabase(List<dynamic> messages) async {
    if (_roomId == "loading" || _myUserId == null) return;
    try {
      final client = supabase.Supabase.instance.client;
      // Use upsert to create or replace the chat history for the room
      await client.from('messages').upsert({
        'room_id': _roomId,
        'user_id': _myUserId, // To know who last updated it
        'messages': messages,
      });
    } catch (e) {
      debugPrint("Error updating history in Supabase: $e");
    }
  }

  // --- STATUS AND MESSAGE SUBSCRIPTIONS ---

  // NEW: Poll every 5 seconds while offline to catch missed updates
  void _startOfflinePolling() {
    _offlinePollTimer?.cancel();
    _offlinePollTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      if (!mounted || _isTargetOnline || _targetUserId == null) return;
      
      // Direct query fallback
      await _fetchTargetStatus();
      
      // If still offline, ensure subscription is alive
      if (!_isTargetOnline) {
        _startStatusSubscription();
      }
    });
  }

  // NEW: Direct status fetch fallback
  Future<void> _fetchTargetStatus() async {
    if (_targetUserId == null) return;
    try {
      final client = supabase.Supabase.instance.client;
      final data = await client
          .from('users')
          .select('is_online, current_room')
          .eq('id', _targetUserId!)
          .maybeSingle();

      if (data != null && mounted) {
        final theirRoom = data['current_room'] as String?;
        final nowInRoom = theirRoom == _roomId;
        final isOnline = data['is_online'] ?? false;
        setState(() {
          _isTargetOnline = nowInRoom || (isOnline && theirRoom == null);
        });
      }
    } catch (e) {
      debugPrint('Error fetching target status: $e');
    }
  }

  void _startStatusSubscription() {
    if (_targetUserId == null) return;

    // Cancel any pending retry
    _statusRetryTimer?.cancel();

    final client = supabase.Supabase.instance.client;

    // REMOVE old channel completely (prevents stale state when reopening chat)
    if (_statusChannel != null) {
      client.removeChannel(_statusChannel!);
    }

    _statusChannel = client.channel('user-status-${_targetUserId!}');

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
            debugPrint('Status payload: ${payload.newRecord}');

            final theirRoom = payload.newRecord['current_room'] as String?;
            final nowInRoom = theirRoom == _roomId;

            // Fallback to is_online if current_room is null
            final isOnline = payload.newRecord['is_online'] ?? false;

            if (mounted) {
              setState(() {
                _isTargetOnline = nowInRoom || (isOnline && theirRoom == null);
              });
            }
          },
        )
        .subscribe((status, [err]) {
          debugPrint('Status subscription state: $status, err: $err');

          if (status == 'SUBSCRIBED') {
            // Success: cancel retry timer, immediately sync status
            _statusRetryTimer?.cancel();
            _fetchTargetStatus();
          } else {
            // Any non-subscribed state → retry in 3 seconds
            _statusRetryTimer?.cancel();
            _statusRetryTimer = Timer(const Duration(seconds: 3), () {
              if (mounted) _startStatusSubscription();
            });
          }
        });
  }

  void _startMessageSubscription() {
    if (_roomId == "loading") return;
    final client = ref.read(clientProvider);

    final messageSubscriptionRequest = GListenToChatReq(
      (b) => b..vars.roomId = _roomId,
    );

    _messageSubscription = client.request(messageSubscriptionRequest).listen((response) {
      if (response.data != null &&
          response.data!.messages != null &&
          response.data!.messages!.isNotEmpty) {
        final newMsg = response.data!.messages!.last;
        
        if (newMsg.user != _myUsername) {
          final currentMessages = List.from(_localHistory);
          final messageMap = {
            'content': newMsg.text,
            'user': newMsg.user,
            'createdAt': newMsg.createdAt ?? DateTime.now().toIso8601String()
          };
          currentMessages.add(messageMap);

          // Platform-aware storage
          if (kIsWeb) {
            _updateHistoryInSupabase(currentMessages);
          } else {
            _saveToLocal(currentMessages);
          }

          widget.onMessageSent?.call(
            newMsg.text,
            DateTime.tryParse(newMsg.createdAt ?? '') ?? DateTime.now(),
          );

          if (mounted) {
            setState(() {});
            _scrollToBottom();
          }
        }
      }
    });
  }

  // --- BLOCKING LOGIC ---
  void _startBlockSubscription() {
    if (_myUserId == null || _targetUserId == null) return;
    final client = supabase.Supabase.instance.client;

    _blockChannel = client.channel('blocks-check');
    _blockChannel!
        .onPostgresChanges(
          event: supabase.PostgresChangeEvent.all,
          schema: 'public',
          table: 'blocks',
          callback: (payload) {
            final record = payload.newRecord.isNotEmpty ? payload.newRecord : payload.oldRecord;
            final blockerId = record['blocker_id'];
            final blockedId = record['blocked_id'];

            if ((blockerId == _myUserId && blockedId == _targetUserId) ||
                (blockerId == _targetUserId && blockedId == _myUserId)) {
              _checkBlockStatus();
            }
          },
        )
        .subscribe();
  }

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
      debugPrint("Block Error: $e");
    }
  }

  // --- HELPERS ---
  String get _roomId {
    if (_myUsername == null) return "loading";
    final users = [_myUsername!, widget.supabaseUsername ?? widget.userName]..sort();
    return users.join('_'); // Readable: alice_bob
  }

  List<dynamic> get _localHistory => _chatBox.get(_roomId, defaultValue: []);

  void _saveToLocal(List<dynamic> messages) {
    _chatBox.put(_roomId, messages);
  }

  Future<void> _sendChat() async {
    await _checkBlockStatus();
    if (_isBlocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You cannot message this user."), backgroundColor: Colors.red),
      );
      return;
    }

    if (_controller.text.trim().isEmpty || _myUsername == null) return;
    
    final newMessage = {
      'content': _controller.text,
      'user': _myUsername,
      'createdAt': DateTime.now().toIso8601String()
    };
    
    final currentMessages = List.from(_localHistory);
    currentMessages.add(newMessage);

    // 1. Always save to local (fast)
    _saveToLocal(currentMessages);

    // 2. ALWAYS save to Supabase (for offline sync & cross-device)
    _updateHistoryInSupabase(currentMessages);

    widget.onMessageSent?.call(newMessage['content'] as String, DateTime.now());
    setState(() {});

    // 3. Send via GraphQL for real-time delivery
    final client = ref.read(clientProvider);
    final sendMessageReq = GSendMessageReq((b) => b
      ..vars.roomId = _roomId
      ..vars.user = _myUsername!
      ..vars.text = _controller.text);

    client.request(sendMessageReq).listen((response) {
      if (response.hasErrors) {
        debugPrint('Error sending message: ${response.graphqlErrors}');
      }
    });

    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        }
      });
    }
  }

  // Status Ring Color
  Color get _statusColor {
    if (_isBlocked) return Colors.red;
    if (_isTargetOnline) return Colors.green;
    return Colors.grey;
  }

  String get _statusText {
    if (_isBlocked) return "Blocked";
    if (_isTargetOnline) return "Online";
    return "Offline";
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
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  _statusText,
                  style: TextStyle(
                      color: _statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.black),
            onPressed: () {
              final callService = ref.read(callServiceProvider);
              callService.initiateCall(widget.userName, 'voice');
              Navigator.push(context, MaterialPageRoute(builder: (_) => Voice(userName: widget.userName, callService: callService)));
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.black),
            onPressed: () {
              final callService = ref.read(callServiceProvider);
              callService.initiateCall(widget.userName, 'video');
              Navigator.push(context, MaterialPageRoute(builder: (_) => Video(userName: widget.userName, callService: callService)));
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              if (value == 'block') _toggleBlock();
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'block',
                  child: Text(_isBlockedByMe ? 'Unblock User' : 'Block User'),
                ),
              ];
            },
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
              // reverse: true, // Set to false to show oldest messages first
              itemBuilder: (context, index) {
                final rawMsg = _localHistory[index];
                final content = rawMsg is Map ? rawMsg['content'] : '';
                final user = rawMsg is Map ? rawMsg['user'] : '';

                final decrypted = SecurityService.decryptMessage(content);
                return _buildMessageBubble(
                    decrypted, user == _myUsername, user);
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
              color: isMe ? Colors.white : Colors.black, fontSize: 16),
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
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: _isBlocked
                    ? 'You cannot reply to this conversation'
                    : 'Type a message...',
                hintStyle: TextStyle(
                    color: _isBlocked
                        ? Colors.redAccent
                        : AppTheme.hint.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
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
