// lib/pages/chat/chatArea.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ConnectUs/services/security_services.dart';
import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/app_theme.dart'; // Import Security Service
import 'package:logger/logger.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';
import 'package:path_provider/path_provider.dart';

class ChatArea extends StatefulWidget {
  final String userName;
  const ChatArea({super.key, required this.userName});

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _myUsername;
  StreamSubscription? _messageSubscription;

  // Local Fallback Storage
  List<Map<String, dynamic>> _localMessages = [];

  @override
  void initState() {
    super.initState();
    _loadMyProfile();
  }

  Future<void> _loadMyProfile() async {
    final user = supabase.Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await supabase.Supabase.instance.client
          .from('users')
          .select('usrname')
          .eq('id', user.id)
          .maybeSingle();
      if (mounted) {
        setState(() {
          _myUsername = data?['usrname'] ?? 'Anonymous';
        });
        _loadLocalHistory(); // Load local file first
        _startSubscription();
      }
    }
  }

  String get _roomId {
    if (_myUsername == null) return "loading";
    final users = [_myUsername!, widget.userName];
    users.sort();
    return users.join("_");
  }

  // --- FILE STORAGE LOGIC (ConnectUs Folder) ---
  Future<File> get _localFile async {
    final appDocDir = await getApplicationDocumentsDirectory();
    // Use the specific ConnectUs folder
    final path = '${appDocDir.path}/ConnectUs/chats';
    final dir = Directory(path);
    if (!await dir.exists()) await dir.create(recursive: true);
    return File('$path/${_roomId}.json');
  }

  Future<void> _loadLocalHistory() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(content);
        setState(() {
          _localMessages = List<Map<String, dynamic>>.from(jsonList);
        });
      }
    } catch (e) {
      print("Error loading local history: $e");
    }
  }

  Future<void> _saveLocalHistory(List<dynamic> messages) async {
    try {
      final file = await _localFile;
      // Convert Ferry/GraphQL classes to simple JSON for storage
      final simplifiedMessages = messages
          .map((m) => {
                'content': m.content, // This is expected to be encrypted/base64
                'user': m.user,
                'createdAt': m.createdAt
              })
          .toList();

      await file.writeAsString(jsonEncode(simplifiedMessages));
    } catch (e) {
      print("Error saving local history: $e");
    }
  }
  // ---------------------------------------------

  void _startSubscription() {
    final client = Provider.of<Client>(context, listen: false);
    final subReq = GOnNewMessageReq((b) => b
      ..vars.roomId = _roomId
      ..updateCacheHandlerKey = 'updateGetMessages');
    _messageSubscription = client.request(subReq).listen(null);
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _sendChat() {
    if (_controller.text.trim().isEmpty || _myUsername == null) return;

    final client = Provider.of<Client>(context, listen: false);
    final rawText = _controller.text.trim();

    // 1. ENCRYPT before sending
    final encryptedContent = SecurityService.encryptMessage(rawText);

    final postMessageReq = GPostMessageReq((b) => b
      ..vars.roomId = _roomId
      ..vars.content = encryptedContent // Send encrypted blob
      ..vars.user = _myUsername!
      ..vars.to = widget.userName
      ..updateCacheHandlerKey = 'updateGetMessages');

    client.request(postMessageReq).listen((response) {
      if (response.hasErrors) Logger().e(response.graphqlErrors);
    });

    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title:
            Text(widget.userName, style: const TextStyle(color: Colors.black)),
        backgroundColor: AppTheme.accentDark,
      ),
      body: Column(
        children: [
          Expanded(
            child: Operation(
              client: Provider.of<Client>(context),
              operationRequest:
                  GGetMessagesReq((b) => b..vars.roomId = _roomId),
              builder: (context, response, error) {
                // FALLBACK LOGIC:
                // If loading or network error, show local data if available.
                List<dynamic> messages = [];

                if (response?.loading == true &&
                    response?.data?.messages == null) {
                  // While loading online, show local
                  if (_localMessages.isNotEmpty) {
                    messages = _localMessages;
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                } else if (response?.data?.messages != null) {
                  // We have online data! Sync it to local storage.
                  messages = response!.data!.messages!.toList();
                  _saveLocalHistory(messages); // Sync happens here
                } else if (_localMessages.isNotEmpty) {
                  // Fallback if online is empty but local exists
                  messages = _localMessages;
                }

                if (messages.isEmpty) {
                  return const Center(child: Text("No messages yet."));
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: messages.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    // Handle both GraphQL Object and Local Map
                    final rawMsg = messages[messages.length - 1 - index];

                    // Helper to get fields safely from either type
                    final content =
                        rawMsg is Map ? rawMsg['content'] : rawMsg.content;
                    final user = rawMsg is Map ? rawMsg['user'] : rawMsg.user;

                    final bool isMe = user == _myUsername;

                    // 2. DECRYPT for display
                    final decryptedContent =
                        SecurityService.decryptMessage(content);

                    return _buildMessageBubble(decryptedContent, isMe, user);
                  },
                );
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String content, bool isMe, String username) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blueGrey[800] : AppTheme.accentDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              content, // Displaying DECRYPTED text
              style: TextStyle(
                  color: isMe ? Colors.white : Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // _buildInputArea remains unchanged...
  Widget _buildInputArea() {
    // ... (Same as your original code) ...
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.black12,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _sendChat(),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: AppTheme.hint.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
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
            backgroundColor: AppTheme.accent,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.black),
              onPressed: _sendChat,
            ),
          ),
        ],
      ),
    );
  }
}
