// lib/pages/chat/chatArea.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:ConnectUs/services/security_services.dart'; 
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';

class ChatArea extends StatefulWidget {
  final String userName; 
  const ChatArea({super.key, required this.userName});

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
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
  bool _isLoadingStatus = true;

  StreamSubscription? _messageSubscription;
  late Box _chatBox;

  // Computed Property for "Are we blocked?"
  bool get _isBlocked => _isBlockedByMe || _isBlockedByThem;

  @override
  void initState() {
    super.initState();
    _chatBox = Hive.box('local_chats');
    _initializeChatSetup();
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
          
      // 2. Get Target User ID from their Username
      final targetData = await client
          .from('users')
          .select('id, is_online') // Assuming 'is_online' column exists
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

        // 3. Check Block Status & Start Listeners
        if (_targetUserId != null) {
          await _checkBlockStatus();
          _startStatusSubscription();
        }
        
        _startSubscription();
      }
    }
  }

  // --- BLOCKING LOGIC ---
  Future<void> _checkBlockStatus() async {
    if (_myUserId == null || _targetUserId == null) return;

    final client = supabase.Supabase.instance.client;

    // Check if I blocked them
    final blockedByMe = await client
        .from('blocks')
        .select()
        .eq('blocker_id', _myUserId!)
        .eq('blocked_id', _targetUserId!)
        .maybeSingle();

    // Check if they blocked me
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
        _isLoadingStatus = false;
      });
    }
  }

  Future<void> _toggleBlock() async {
    if (_myUserId == null || _targetUserId == null) return;
    final client = supabase.Supabase.instance.client;

    try {
      if (_isBlockedByMe) {
        // Unblock
        await client
            .from('blocks')
            .delete()
            .eq('blocker_id', _myUserId!)
            .eq('blocked_id', _targetUserId!);
        setState(() => _isBlockedByMe = false);
      } else {
        // Block
        await client
            .from('blocks')
            .insert({
              'blocker_id': _myUserId,
              'blocked_id': _targetUserId,
            })