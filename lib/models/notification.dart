class Notification {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timestamp;
  final bool isRead;

  Notification({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
    required this.isRead,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'isRead': isRead,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      text: map['text'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      isRead: map['isRead'],
    );
  }
}