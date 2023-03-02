import 'package:flutter/material.dart';
import 'package:stumble/hooks/fetchNearbyUsers.dart';
import 'package:stumble/hooks/fetchUserDetails.dart';
import 'package:stumble/models/User.dart';
import 'package:stumble/models/UserDetails.dart';

import '../hooks/blockUser.dart';

class Users with ChangeNotifier {
  List<User>? _users = [];
  String? authToken;
  double? lat;
  double? lon;

  Users(this.authToken, this.lat, this.lon, this._users);

  List<User> get items {
    if (_users != null) {
      return [...?_users];
    }
    return [];
  }

  Future<UserDetails> getUserDetailsById(String id) async {
    final UserDetails userDetails = await fetchUserDetails(id, authToken!);
    return userDetails;
  }

  Future<void> getNearbyUsers() async {
    try {
      final List<User> loadedUsers =
          await fetchNearbyUsers(lat!, lon!, authToken!);

      _users = loadedUsers;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> setBlockUser(String email) async {
    try {
      await blockUser(email, authToken!);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
