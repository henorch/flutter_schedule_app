import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:world_times/src/features/presntations/model/postmodel.dart';

class FetchPostServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> fetchCurrentUser(user) async {
    try {
      DocumentSnapshot userdata =
          await _firestore.collection('users').doc(user.uid).get();

      if (userdata.exists) {
        return userdata['username'];
      } else {
        return 'Error: User document does not exist';
      }
    } catch (e) {
      // print(e);
    }
    return "";
  }

// fetch plans

  // Fetch post by category

  // Fetch all posts for the current user by UID
  Future<List<PostModel>> fetchAllPostByCurrentUser(uid) async {
    try {
      // Fetch the documents from Firestore where 'owner' is equal to the provided UID
      await Future.delayed(Duration(seconds: 2));
      QuerySnapshot querySnapshot = await _firestore
          .collection('posts')
          .where('owner', isEqualTo: uid)
          .get();

      // Convert the QueryDocumentSnapshot to PostModel
      List<PostModel> posts =
          querySnapshot.docs.map((doc) => PostModel.fromDocument(doc)).toList();
      return posts;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print('Error deleting post: $e');
    }
  }
}
