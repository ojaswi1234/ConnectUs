import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';


// String roomId = "UserA-UserB";
// Local aliases for readability (use AppTheme)
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
  TextEditingController controller = TextEditingController();
  List<Chat> sendmessages = [];
  final ScrollController _scrollController = ScrollController();

  bool isBlocked = false;

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  void sendChat() {
    if (controller.text.isNotEmpty) {
      /* final messageText = controller.text.trim();

      final chat = Chat(
        message: messageText,
        timestamp: DateTime.now(),
        senderId: 'me',
      );

      // Add message to local list immediately for better UX
      setState(() {
        sendmessages.add(chat);
      });

      controller.clear();

      // Auto-scroll to bottom when sending
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
      */
    }
  }

  final List<String> actionList = [
    "Img",
    "Voice",
    "Doc",
    "Locate",
    "Contact",
  ];

  final Map<String, IconData> iconMap = {
    "Img": Icons.image,
    "Voice": Icons.mic,
    "Doc": Icons.document_scanner,
    "Locate": Icons.location_on,
    "Contact": Icons.person,
  };

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.userName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leadingWidth: 72,
        elevation: 7,
        shadowColor: kAccentColor,
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'profile_settings',
                child: Text('Profile Settings'),
              ),
              PopupMenuItem<String>(
                value: 'clear_chat',
                child: Text('Clear Chat'),
              ),
              PopupMenuItem<String>(
                value: 'back',
                child: Text('Back to Chats'),
              ),
            ],
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              // Handle menu selection
              if (value == 'profile_settings') {
                Navigator.pushNamed(context, '/profile');
              }
              if (value == 'back') {
                Navigator.pushNamed(context, '/home');
              }
              if (value == 'clear_chat') {
                setState(() {
                  sendmessages.clear();
                });
              }
            },
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(''),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 72,
                          backgroundImage:
                              AssetImage('assets/images/profile.png'),
                        ),
                        SizedBox(height: 16),
                        Text('My Number', style: TextStyle(fontSize: 18)),
                        Text('user@example.com',
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.message)),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.call)),
                          ],
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            shape: CircleBorder(
              side: BorderSide(
                color: kTextColor,
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(bottom: (width < 600 ? 32 : 0)),
        color: kBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: sendmessages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: kAccentColor.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No messages yet. Start the conversation!",
                            style: TextStyle(
                              color: kAccentColor.withOpacity(0.7),
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16.0),
                      itemCount: sendmessages.length,
                      reverse: true, // Show newest messages at bottom
                      itemBuilder: (context, index) {
                        // Reverse index for correct message order
                        final message =
                            sendmessages[sendmessages.length - 1 - index];
                        final bool isMe = message.senderId == 'me';

                        return GestureDetector(
                          onLongPress: () {
                            showMenu(
                                    context: context,
                                    items: [
                                      PopupMenuItem(
                                        value: 'copy',
                                        child: Text('Copy'),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Text('Delete'),
                                      ),
                                    ],
                                    position:
                                        RelativeRect.fromLTRB(100, 100, 0, 0))
                                .then((value) {
                              if (value == 'copy') {
                                Clipboard.setData(
                                    ClipboardData(text: message.message));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Message copied to clipboard')),
                                );
                              } else if (value == 'delete') {
                                setState(() {
                                  sendmessages.removeAt(
                                      sendmessages.length - 1 - index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Message deleted')),
                                );
                              }
                            });
                          },
                          child: Container(
                            alignment: (isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft),
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75,
                              ),
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      color: (isMe
                                          ? Colors.grey[800]
                                          : kPrimaryColor),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          message.message,
                                          style: TextStyle(
                                              color: isMe
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                                              style: TextStyle(
                                                  color: isMe
                                                      ? Colors.white70
                                                      : Colors.black54,
                                                  fontSize: 12),
                                            ),
                                            if (isMe) ...[
                                              const SizedBox(width: 4),
                                              Icon(Icons.check,
                                                  color: Colors.blue, size: 14),
                                            ],
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            // Input area
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: kTextColor, width: 1.0),
                      ),
                      child: TextFormField(
                        controller: controller,
                        style: const TextStyle(color: Colors.white),
                        maxLines: null, // Allow multiple lines
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle:
                              TextStyle(color: kAccentColor.withOpacity(0.7)),
                          filled: false,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          suffixIcon: PopupMenuButton<String>(
                            icon: Transform.rotate(
                              angle: 3.14 / 2,
                              child:
                                  Icon(Icons.attachment, color: kPrimaryColor),
                            ),
                            color: const Color.fromARGB(255, 0, 0, 0),
                            itemBuilder: (context) => actionList.map((e) {
                              return PopupMenuItem<String>(
                                value: e,
                                child: Row(
                                  children: [
                                    Icon(iconMap[e], color: kTextColor),
                                    const SizedBox(width: 8),
                                    Text(e,
                                        style: TextStyle(color: kTextColor)),
                                  ],
                                ),
                                onTap: () async {
                                  // Handle action selection
                                  try {
                                    switch (e) {
                                      case "Img":
                                        final result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.image,
                                        );
                                        if (result != null &&
                                            result.files.isNotEmpty) {
                                          final file = result.files.first;
                                          Logger().i(
                                              'Selected image: ${file.name}, size: ${file.size} bytes');
                                        } else {
                                          Logger().w('No image selected');
                                        }
                                        break;
                                      case "Voice":
                                        final result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.audio,
                                        );
                                        if (result != null &&
                                            result.files.isNotEmpty) {
                                          final file = result.files.first;
                                          Logger().i(
                                              'Selected audio: ${file.name}, size: ${file.size} bytes');
                                        } else {
                                          Logger().w('No audio selected');
                                        }
                                        break;
                                      case "Doc":
                                        final result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.any,
                                        );
                                        if (result != null &&
                                            result.files.isNotEmpty) {
                                          final file = result.files.first;
                                          Logger().i(
                                              'Selected document: ${file.name}, size: ${file.size} bytes');
                                        } else {
                                          Logger().w('No document selected');
                                        }
                                        break;
                                      case "Locate":
                                        Logger().i(
                                            'Location sharing not implemented yet.');
                                        break;
                                      case "Contact":
                                        Logger().i(
                                            'Contact sharing not implemented yet.');
                                        break;
                                    }
                                  } catch (error) {
                                    Logger().e('Error selecting file: $error');
                                  }
                                },
                              );
                            }).toList(),
                            onSelected: (value) {
                              debugPrint(value);
                            },
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            sendChat();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      sendChat();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                      foregroundColor: kPrimaryColor,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12.0),
                      elevation: 2.0,
                      minimumSize: const Size(44.0, 44.0),
                    ),
                    child: Icon(
                      Icons.send,
                      color: Color(0xFF1E1E1E),
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Chat {
  final String message;
  final DateTime timestamp;
  final String senderId;

  Chat({
    required this.message,
    required this.timestamp,
    required this.senderId,
  });

  factory Chat.fromJSON(Map<String, dynamic> json) => Chat(
        message: json['message'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
        senderId: json['senderId'] as String,
      );

  Map<String, dynamic> toJSON() => {
        'message': message,
        // 'timestamp': timestamp.toIso861String(),
        'senderId': senderId,
      };
}
