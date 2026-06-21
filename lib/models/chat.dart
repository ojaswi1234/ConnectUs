
class Chats {
  final String contactName;
  String? supabaseUsername;
  String? roomId; // ADD THIS
  String lastMessage;
  DateTime lastMessageTime;
  int unreadCount;

  Chats({
    required this.contactName,
    this.supabaseUsername,
    this.roomId,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chats &&
          runtimeType == other.runtimeType &&
          contactName == other.contactName;

  @override
  int get hashCode => contactName.hashCode;
}
