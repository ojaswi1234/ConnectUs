import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:logger/logger.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:provider/provider.dart'; // Use standard Provider
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';

// Local aliases for readability
final kPrimaryColor = AppTheme.accentDark;
final kSecondaryColor = AppTheme.accent;
final kBackgroundColor = AppTheme.background;
final kAccentColor = AppTheme.hint;
final kTextColor = AppTheme.accent;

class ChatArea extends StatefulWidget {
  final String userName;
  const ChatArea({super.key, required this.userName});

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  void sendChat() {
    if (controller.text.trim().isEmpty) return;

    // 1. Get the client using Provider
    final client = Provider.of<Client>(context, listen: false);
    final messageText = controller.text.trim();

    // 2. Create the request based on your schema (postMessage)
    final postMessageReq = GPostMessageReq(
      (b) => b
        ..vars.content = messageText
        ..vars.user = 'me', // Matches 'user' in your schema
    );

    // 3. Execute request
    client.request(postMessageReq).listen((response) {
      if (response.hasErrors) {
        Logger().e("Failed to send: ${response.graphqlErrors}");
      }
    });

    controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0, // Because ListView is reversed, 0.0 is the bottom
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 4. Matches 'query GetMessages' in operations.graphql
    final getMessagesReq = GGetMessagesReq();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        
      ),
      body: Container(
        color: kBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: Operation(
                client: Provider.of<Client>(context),
                operationRequest: getMessagesReq,
                builder: (context, response, error) {
                  if (response?.loading ?? true)
                    return const Center(child: CircularProgressIndicator());

                  final messages = response?.data?.messages?.toList() ?? [];

                  if (messages.isEmpty) {
                    return const Center(
                        child: Text("No messages yet.",
                            style: TextStyle(color: Colors.white)));
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16.0),
                    itemCount: messages.length,
                    reverse: true, // Newest at bottom
                    itemBuilder: (context, index) {
                      // Reverse logic: messages are usually returned [oldest...newest]
                      // With reverse:true, index 0 is the bottom of the screen.
                      final message = messages[messages.length - 1 - index];
                      final bool isMe = message.user == 'me';

                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blueGrey[800] : kPrimaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            message.content,
                            style: TextStyle(
                                color: isMe ? Colors.white : Colors.black),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: kAccentColor.withOpacity(0.5)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: sendChat,
            backgroundColor: kSecondaryColor,
            child: const Icon(Icons.send, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
