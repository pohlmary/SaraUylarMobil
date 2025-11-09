class Review {
  final String id;
  final String houseId;
  final String userId;
  final String text;
  final int rating;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.houseId,
    required this.userId,
    required this.text,
    required this.rating,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'houseId': houseId,
      'userId': userId,
      'text': text,
      'rating': rating,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'],
      houseId: map['houseId'],
      userId: map['userId'],
      text: map['text'],
      rating: map['rating'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }
}