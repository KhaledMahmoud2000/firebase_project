import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';
import '../models/comment.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _postsCollection = 'posts';

  Stream<List<Post>> getPostsStream() {
    return _firestore
        .collection(_postsCollection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Post.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }


  Stream<List<Comment>> getCommentsStream(String postId) {
    return _firestore
        .collection(_postsCollection)
        .doc(postId)
        .collection('comments')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Comment.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }


  Future<String> addComment(String postId, String text) async {
    try {
      const String currentUserId = 'user_123';
      const String currentUserName = 'Current User';

      final commentData = {
        'text': text,
        'authorId': currentUserId,
        'authorName': currentUserName,
        'createdAt': FieldValue.serverTimestamp(),
      };

      final docRef = await _firestore
          .collection(_postsCollection)
          .doc(postId)
          .collection('comments')
          .add(commentData);

      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add comment: $e');
    }
  }
}