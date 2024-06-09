import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String postId;
  String postTitle;
  String postDescription;
  String postOwnerId;
  String postCategory;

  PostModel(
      {required this.postId,
      required this.postCategory,
      required this.postDescription,
      required this.postTitle,
      required this.postOwnerId});

  factory PostModel.fromDocument(DocumentSnapshot doc) {
    return PostModel(
      postId: doc.id,
      postTitle: doc['title'],
      postDescription: doc['description'],
      postOwnerId: doc['owner'],
      postCategory: doc['category'],
    );
  }

  @override
  String toString() {
    return 'PostModel{postId: $postId,  postTitle: $postTitle, postDescription: $postDescription, postOwnerId: $postOwnerId, postCategory: $postCategory}';
  }
}
