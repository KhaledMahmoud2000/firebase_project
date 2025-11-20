
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final String authorName;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
  });

  factory Post.fromFirestore(Map<String, dynamic> data, String id) {
    return Post(
      id: id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      authorId: data['userId'] ?? '',              // بدل 'authorId'
      authorName: data['authorName'] ?? 'User',   // لو مش موجود، خلي اسم افتراضي
      createdAt: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(), // بدل 'createdAt'
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'userId': authorId,               // بدل 'authorId'
      'authorName': authorName,
      'timestamp': FieldValue.serverTimestamp(), // بدل 'createdAt'
    };
  }

}