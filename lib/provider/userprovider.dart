import 'package:flutter/material.dart';
import 'package:world_times/local_storages/share_pref.dart';

class UserProvider extends ChangeNotifier {
  final LocalStorage _sharedPrefService = LocalStorage();
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  UserProvider() {
    _loadLoginStatus();
  }

  Future<void> _loadLoginStatus() async {
    _isLoggedIn = await _sharedPrefService.getLoginStatus();
    notifyListeners();
  }

  Future<void> login() async {
    _isLoggedIn = true;
    await _sharedPrefService.setLoginStatus(true);
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    await _sharedPrefService.setLoginStatus(false);
    notifyListeners();
  }
}
