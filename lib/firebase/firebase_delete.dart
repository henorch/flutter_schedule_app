import 'package:cloud_firestore/cloud_firestore.dart';

class FireDelete {
  final FirebaseFirestore _deletePost = FirebaseFirestore.instance;

  Future<void> postToDelete(String postId) async {
    await _deletePost.collection('posts').doc(postId).delete();
  }
}
