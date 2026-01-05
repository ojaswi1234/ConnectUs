import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:logger/logger.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';

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

  @override
  void initState() {
    super.initState();
    _loadMyProfile();
  }

  /// Retrieves the current user's username from Supabase
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
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _sendChat() {
    if (_controller.text.trim().isEmpty || _myUsername == null) return;

    final client = Provider.of<Client>(context, listen: false);
    final messageText = _controller.text.trim();

    // Use the PostMessage mutation
    final postMessageReq = GPostMessageReq(
      (b) => b
        ..vars.content = messageText
        ..vars.user = _myUsername,
    );

    client.request(postMessageReq).listen((response) {
      if (response.hasErrors) {
        Logger().e("Failed to send: ${response.graphqlErrors}");
      }
    });

    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0, // Because ListView is reversed, 0.0 is the bottom
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Get initial history
    final getMessagesReq = GGetMessagesReq();
    // 2. Listen for new messages (Subscription)
    final onNewMessageReq = GOnNewMessageReq();

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
            // ADDED LOGIC: Nest the Query Operation inside the Subscription Operation.
            // This ensures the real-time connection stays open while you're on this screen.
            child: Operation(
              client: Provider.of<Client>(context),
              operationRequest: onNewMessageReq,
              builder: (context, subResponse, subError) {
                // The Subscription updates the cache; this Query Operation watches the cache.
                return Operation(
                  client: Provider.of<Client>(context),
                  operationRequest: getMessagesReq,
                  builder: (context, response, error) {
                    if (response?.loading ?? true) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final messages = response?.data?.messages?.toList() ?? [];

                    if (messages.isEmpty) {
                      return const Center(
                          child: Text("No messages yet.",
                              style: TextStyle(color: AppTheme.muted)));
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16.0),
                      itemCount: messages.length,
                      reverse: true, // Newest at the bottom
                      itemBuilder: (context, index) {
                        final message = messages[messages.length - 1 - index];
                        final bool isMe = message.user == _myUsername;

                        return _buildMessageBubble(message, isMe);
                      },
                    );
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

  Widget _buildMessageBubble(dynamic message, bool isMe) {
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