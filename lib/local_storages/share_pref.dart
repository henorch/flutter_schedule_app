import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _isLoggedInKey = 'isLoggedIn';

  // put data in shared preferences
  static Future<void> saveToSharedPreference(String key, String value) async {
    SharedPreferences sharedpreference = await SharedPreferences.getInstance();
    await sharedpreference.setString(key, value);
  }

  static Future<void> saveThemePreference(String key, bool value) async {
    SharedPreferences sharedpreference = await SharedPreferences.getInstance();
    await sharedpreference.setBool(key, value);
  }

  Future<void> setLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, status);
  }

  Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

// retrieve data from shared preference
  static Future<String?> getFromSharedPreference(String key) async {
    SharedPreferences sharedpreference = await SharedPreferences.getInstance();
    return sharedpreference.getString(key);
  }

  static Future<bool?> getThemePreference(String key) async {
    SharedPreferences sharedpreference = await SharedPreferences.getInstance();
    return sharedpreference.getBool(key);
  }

// remove data from shared preference
  static Future<void> removeFromSharePreference(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }
}
