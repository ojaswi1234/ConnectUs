
class Chats {
  final String contactName;
  String lastMessage;
  DateTime lastMessageTime;
  int unreadCount;

  Chats({
    required this.contactName,
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
