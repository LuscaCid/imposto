import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imposto/contracts/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  static const _themeModeKey = 'theme_mode';
  static const _userAuthKey = 'user_auth_key';
  static const _userJSONKey = 'user_json_key';

  ThemeMode _currentThemeMode = ThemeMode.system;
  String? _userUUID; 
  User? _user;


  ThemeMode get currentThemeMode => _currentThemeMode;
  User? get user => _user;
  // bool get isAuthenticated => _userUUID != null;
  bool get isAuthenticated => true;

  Future<User?> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _loadTheme(prefs);
    _loadAuthentication(prefs);

    notifyListeners();

    return _user;
  }

  void _loadTheme (SharedPreferences prefs) {
    final themeString = prefs.getString(_themeModeKey);
    _currentThemeMode = themeString == "light"
      ? ThemeMode.light
      : themeString == "dark"
      ? ThemeMode.dark
      : ThemeMode.system;
  }

  void _loadAuthentication (SharedPreferences prefs) {
    _userUUID = prefs.getString(_userAuthKey);
    final jsonEncoded = prefs.getString(_userJSONKey);

    if(jsonEncoded != null && jsonEncoded.isNotEmpty){
      final userCachedJson = jsonDecode(jsonEncoded) as Map<String, dynamic>;
        _user = User.fromJson(userCachedJson);
        return;
    }
  }

  Future<void> toggleThemeMode() async {
    final prefs = await SharedPreferences.getInstance();

    if (_currentThemeMode == ThemeMode.light ||
        _currentThemeMode == ThemeMode.system) {
      _currentThemeMode = ThemeMode.dark;
      await prefs.setString(_themeModeKey, 'dark');
    } else {
      _currentThemeMode = ThemeMode.light;
      await prefs.setString(_themeModeKey, 'light');
    }

    notifyListeners();
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userAuthKey);
    await prefs.remove(_userJSONKey);

    _userUUID = null;
    _user = null;

    notifyListeners();
  }
}