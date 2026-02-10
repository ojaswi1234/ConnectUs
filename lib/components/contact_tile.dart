import 'package:ConnectUs/pages/chat/chat_area.dart';
import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/app_theme.dart';

class ContactTile extends StatelessWidget {
  final String contactName;
  final String lastMessage;
  final int unreadCount;
  const ContactTile({super.key, required this.contactName, required this.lastMessage, this.unreadCount = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onLongPress: () async {
              final details = await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(MediaQuery.of(context).size.width - 200, 200, 20, 20),
                items: [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete Chat', style: AppTheme.titleStyle),
                  ),
                  const PopupMenuItem(
                    value: 'mute',
                    child: Text('Mute Notifications', style: AppTheme.titleStyle),
                  ),
                ],
                color: AppTheme.background,
              );

              if (details == 'delete') {
                // handle delete
              } else if (details == 'mute') {
                // handle mute
              }
            },
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatArea(userName: contactName),
              ),
            ),
            child: Container(
              decoration: AppTheme.cardDecoration,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: AppTheme.accentDark,
                      child: Text(
                        contactName.isNotEmpty ? contactName[0].toUpperCase() : 'A',
                        style: const TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contactName, style: AppTheme.titleStyle, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 6),
                        Text(lastMessage, style: AppTheme.subtitleStyle, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  if (unreadCount > 0) ...[
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          unreadCount > 99 ? '99+' : unreadCount.toString(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                  ] else ...[
                    const SizedBox(width: 12),
                  ]
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}