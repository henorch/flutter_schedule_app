import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String id;
  String title;
  String description;
  String? owner;
  String category;

  PostModel(
      {required this.id,
      required this.category,
      required this.description,
      required this.title,
      this.owner});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'owner': owner
    };
  }

  factory PostModel.fromDocument(DocumentSnapshot doc) {
    return PostModel(
      id: doc.id,
      title: doc['title'],
      description: doc['description'],
      owner: doc['owner'],
      category: doc['category'],
    );
  }

  @override
  String toString() {
    return 'PostModel{id: $id,  title: $title, description: $description, owner: $owner, category: $category}';
  }
}
