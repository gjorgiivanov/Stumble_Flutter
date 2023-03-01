import 'package:flutter/material.dart';
import 'package:stumble/hooks/fetchNearbyUsers.dart';
import 'package:stumble/hooks/fetchUserDetails.dart';
import 'package:stumble/models/User.dart';
import 'package:stumble/models/UserDetails.dart';

class Users with ChangeNotifier {
  List<User>? _users = [];
  final double? lat;
  final double? lon;
  final String? authToken;

  Users(this.authToken, {this.lat, this.lon});

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
      final List<User> loadedUsers = await fetchNearbyUsers(10, 10, authToken!);
      _users = loadedUsers;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
