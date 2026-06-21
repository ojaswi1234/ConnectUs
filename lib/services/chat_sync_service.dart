import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:flutter/material.dart';

class ChatSyncService {
  static final ChatSyncService _instance = ChatSyncService._internal();
  factory ChatSyncService() => _instance;
  ChatSyncService._internal();

  final _messageStream = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get messageStream => _messageStream.stream;

  supabase.RealtimeChannel? _channel;
  String? _myUsername;
  bool _initialized = false;

  /// Rooms that have unsaved local messages not yet flushed to Supabase.
  final Set<String> _pendingSyncRooms = {};

  /// Called by chat_area on every send to mark the room as dirty.
  void markPendingSync(String roomId) {
    _pendingSyncRooms.add(roomId);
  }

  Future<void> initialize() async {
    if (_initialized) return;
    final user = supabase.Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final myData = await supabase.Supabase.instance.client
        .from('users')
        .select('usrname')
        .eq('id', user.id)
        .maybeSingle();
    _myUsername = myData?['usrname'];
    if (_myUsername == null) return;

    _listenToMessages();
    _initialized = true;
  }

  void _listenToMessages() {
    _channel = supabase.Supabase.instance.client.channel('global-messages');

    _channel!
        .onPostgresChanges(
          event: supabase.PostgresChangeEvent.all,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            final record = payload.newRecord;
            final roomId = record['room_id'] as String?;
            final messages = record['messages'] as List?;
            if (roomId == null || messages == null) return;

            if (_isMyRoom(roomId)) {
              _syncToLocal(roomId, messages);
              _messageStream.add({
                'room_id': roomId,
                'messages': messages,
                'type': 'realtime',
              });
            }
          },
        )
        .subscribe((status, [err]) {
          debugPrint('Global messages subscription: $status');
        });
  }

  bool _isMyRoom(String roomId) {
    if (_myUsername == null) return false;
    return roomId.startsWith('${_myUsername}_') ||
           roomId.endsWith('_${_myUsername}') ||
           roomId.contains('_${_myUsername}_');
  }

  Future<void> _syncToLocal(String roomId, List messages) async {
    if (kIsWeb) return;
    try {
      final box = Hive.box('local_chats');
      await box.put(roomId, messages);
    } catch (e) {
      debugPrint('Error syncing to local: $e');
    }
  }

  /// Call this when app comes online (foreground, resume, startup)
  Future<void> fetchMissedMessages() async {
    if (_myUsername == null) return;
    try {
      final response = await supabase.Supabase.instance.client
          .from('messages')
          .select('room_id, messages, updated_at')
          .or('room_id.ilike.${_myUsername}_%, room_id.ilike.%_${_myUsername}');

      if (kIsWeb) return; // Web reads directly from Supabase

      final box = Hive.box('local_chats');
      for (final row in response) {
        final roomId = row['room_id'] as String;
        final remoteMessages = List.from(row['messages'] ?? []);

        final localMessages = List.from(box.get(roomId, defaultValue: []) as List);

        // Merge: deduplicate by user+content+time
        final localKeys = localMessages.map((m) => '${m['user']}:${m['content']}:${m['createdAt']}').toSet();
        final newOnes = remoteMessages.where((m) {
          final key = '${m['user']}:${m['content']}:${m['createdAt']}';
          return !localKeys.contains(key);
        }).toList();

        if (newOnes.isNotEmpty) {
          final merged = [...localMessages, ...newOnes];
          await box.put(roomId, merged);
          _messageStream.add({
            'room_id': roomId,
            'messages': merged,
            'new_count': newOnes.length,
            'type': 'catchup',
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching missed messages: $e');
    }
  }

  /// Flush all pending (dirty) local chat rooms to Supabase.
  /// Call this on: app paused/detached, periodic timer, or when recipient goes offline.
  Future<void> syncAllLocalChatsToSupabase() async {
    if (kIsWeb || _pendingSyncRooms.isEmpty) return;
    final user = supabase.Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final box = Hive.box('local_chats');
    final client = supabase.Supabase.instance.client;

    // Snapshot and clear the set before async work to avoid double-flush.
    final roomsToSync = Set<String>.from(_pendingSyncRooms);
    _pendingSyncRooms.clear();

    for (final roomId in roomsToSync) {
      try {
        final messages = List.from(box.get(roomId, defaultValue: []) as List);
        if (messages.isEmpty) continue;

        await client.from('messages').upsert({
          'room_id': roomId,
          'user_id': user.id,
          'messages': messages,
        });
        debugPrint('[ChatSyncService] Flushed $roomId (${messages.length} msgs) to Supabase.');
      } catch (e) {
        // Re-queue if sync failed so next flush can retry.
        _pendingSyncRooms.add(roomId);
        debugPrint('[ChatSyncService] Sync failed for $roomId: $e');
      }
    }
  }

  String getOtherUserFromRoomId(String roomId) {
    if (_myUsername == null) return roomId;
    return roomId.replaceFirst('${_myUsername}_', '').replaceFirst('_${_myUsername}', '');
  }

  void dispose() {
    if (_channel != null) {
      supabase.Supabase.instance.client.removeChannel(_channel!);
    }
    _messageStream.close();
  }
}
