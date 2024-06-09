import 'package:flutter/material.dart';
import 'package:world_times/firebase/firebase_post.dart';
import 'package:world_times/src/features/presntations/model/postmodel.dart';

import '../../../../local_storages/share_pref.dart';

class PostProvider extends ChangeNotifier {
  final FetchPostServices _fetcPost = FetchPostServices();

  final List<PostModel> _postModels = [];
  bool _isloading = false;
  String? _errorMessage;

  List<PostModel> get postModels => List.unmodifiable(_postModels);
  bool get isLoading => _isloading;
  String? get errorMessage => _errorMessage;

  void fetchAllPostByCurrentUser(String uid) async {
    String? uid = await LocalStorage.getFromSharedPreference('userid');
    _isloading = true;
    notifyListeners();
    try {
      _postModels.clear();
      List<PostModel> fetchAll = await _fetcPost.fetchAllPostByCurrentUser(uid);
      _postModels.addAll(fetchAll);
    } catch (e) {
      _errorMessage = 'Error fetching data: $e';
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  List<PostModel> filterPostsByCategory(String category) {
    return _postModels.where((post) => post.postCategory == category).toList();
  }

  Future<void> deletePost(String postId) async {
    try {
      await _fetcPost.deletePost(postId);
      _postModels.removeWhere((post) => post.postId == postId);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error deleting post: $e';
      notifyListeners();
    }
  }

  void updatePost(PostModel updatedPost) {
    final index =
        _postModels.indexWhere((post) => post.postId == updatedPost.postId);
    if (index != -1) {
      _postModels[index] = updatedPost;
      notifyListeners();
    }
  }
}
