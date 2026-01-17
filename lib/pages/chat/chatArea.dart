import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:ConnectUs/services/socket_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class Message {
  final String content;
  final String user;
  final bool isMe;

  Message({required this.content, required this.user, required this.isMe});
}

class ChatArea extends StatefulWidget {
  final String userName; // The person you are chatting with
  const ChatArea({super.key, required this.userName});

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _myUsername;
  final SocketService _socketService = SocketService();
  final List<Message> _messages = [];

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
        _initializeSocket();
      }
    }
  }

  void _initializeSocket() {
    _socketService.connect();
    _socketService.register(_myUsername!);
    _socketService.addMessageListener(widget.userName, (message) {
      setState(() {
        _messages.insert(
            0,
            Message(
              content: message['content'],
              user: message['from'],
              isMe: message['from'] == _myUsername,
            ));
      });
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _socketService.removeMessageListener(widget.userName);
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _sendChat() {
    if (_controller.text.trim().isEmpty || _myUsername == null) return;

    final messageText = _controller.text.trim();
    _socketService.sendMessage(widget.userName, _myUsername!, messageText);

    setState(() {
      _messages.insert(0, Message(
        content: messageText,
        user: _myUsername!,
        isMe: true,
      ));
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
        title: Row(children: [
          CircleAvatar(
            backgroundColor: AppTheme.accent,
            child: const Icon(Icons.person, color: Colors.black, size: 20),
          ),
          const SizedBox(width: 10),
          Text(widget.userName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold))
        ]),
        backgroundColor: AppTheme.accentDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    const PopupMenuItem(child: Text("Delete Chat")),
                    const PopupMenuItem(child: Text("Mute Chat")),
                    const PopupMenuItem(child: Text("Block Chat")),
                    const PopupMenuItem(child: Text("Clear Chat")),
                  ])
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message, message.isMe);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message, bool isMe) {
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
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                  color: isMe ? Colors.white : Colors.black, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              isMe ? "You" : message.user,
              style: TextStyle(
                color: isMe ? Colors.white70 : Colors.black54,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
