import 'package:flutter/material.dart';

class Chat {
  final String roomId;
  final String lastMessage;
  final String contactName;
  final DateTime timestamp;

  Chat({
    required this.roomId,
    required this.lastMessage,
    required this.contactName,
    required this.timestamp,
  });
}
