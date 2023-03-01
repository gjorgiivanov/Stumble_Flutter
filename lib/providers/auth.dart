import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stumble/hooks/login.dart' as login_hook;
import 'package:stumble/hooks/register.dart' as register_hook;
import 'package:stumble/models/UserDetails.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    return _token;
  }

  Future<void> register(
    String firstName,
    String lastName,
    File image,
    String gender,
    String email,
    String password,
    String description,
    String instagramAccount,
    String facebookAccount,
    String linkedinAccount,
  ) async {
    try {
      final responseData = await register_hook.register(
        firstName,
        lastName,
        image,
        gender,
        email,
        password,
        description,
        instagramAccount,
        facebookAccount,
        linkedinAccount,
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final responseData = await login_hook.login(email, password);

      _token = responseData.accessToken;
      UserDetails userDetails = responseData.userDetails;
      _userId = userDetails.email;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  void logout() async {
    _token = null;
    _userId = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }
    final userData =
        json.decode(prefs.getString("userData")!) as Map<String, Object>;
    _token = userData['token'] as String?;
    _userId = userData['userId'] as String?;
    notifyListeners();
    return true;
  }
}
