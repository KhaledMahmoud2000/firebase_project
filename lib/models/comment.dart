
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String text;
  final String authorId;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.text,
    required this.authorId,
    required this.createdAt,
  });

  factory Comment.fromFirestore(Map<String, dynamic> data, String id) {
    return Comment(
      id: id,
      text: data['text'] ?? '',
      authorId: data['userId'] ?? 'Unknown',
      createdAt: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'text': text,
      'userId': authorId,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
