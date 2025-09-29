class Message {
  final int id;
  final int senderId;
  final String senderType;
  final int userId;
  final String content;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.senderId,
    required this.senderType,
    required this.userId,
    required this.content,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['sender_id'],
      senderType: json['sender_type'],
      userId: json['user_id'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}