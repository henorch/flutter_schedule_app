import 'package:flutter/material.dart';
import 'package:world_times/firebase/firebase_post.dart';
import 'package:world_times/local_storages/share_pref.dart';

import '../model/postmodel.dart';

class PostProvider extends ChangeNotifier {
  final FetchPostServices _firestoreService = FetchPostServices();
  final List<PostModel> _postModels = [];

  List<PostModel> get postModels => List.unmodifiable(_postModels);
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAllPosts() async {
    String? uid = await LocalStorage.getFromSharedPreference('userid');
    _isLoading = true;
    notifyListeners();
    try {
      List<PostModel> posts =
          await _firestoreService.fetchAllPostByCurrentUser(uid);
      _postModels.clear();
      _postModels.addAll(posts);
    } catch (e) {
      _errorMessage = 'Error fetching posts: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<PostModel> filterPostsByCategory(String category) {
    return _postModels.where((post) => post.category == category).toList();
  }

  Future<void> addPost(PostModel postModel) async {
    String? owner = await LocalStorage.getFromSharedPreference('userid');
    if (owner == null) {
      return;
    }
    try {
      await _firestoreService.addSchedule(owner, postModel);
      _postModels.add(postModel);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error adding post: $e';
      notifyListeners();
    }
  }

  Future<void> updatePost(String postId, PostModel updatedPost) async {
    try {
      await _firestoreService.updatePost(postId, updatedPost);
      int index = _postModels.indexWhere((post) => post.id == updatedPost.id);
      print(' this is post.id ${postId}');
      print('this is updateId ${updatedPost.id}');
      if (index != -1) {
        _postModels[index] = updatedPost;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Error updating post: $e';
      notifyListeners();
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestoreService.deletePost(postId);
      _postModels.removeWhere((post) => post.id == postId);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error deleting post: $e';
      notifyListeners();
    }
  }
}
