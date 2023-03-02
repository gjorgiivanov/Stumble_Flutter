import 'package:flutter/material.dart';
import 'package:stumble/hooks/fetchNearbyUsers.dart';
import 'package:stumble/hooks/fetchUserDetails.dart';
import 'package:stumble/hooks/getConversations.dart';
import 'package:stumble/hooks/addConversation.dart';
import 'package:stumble/models/User.dart';
import 'package:stumble/models/UserDetails.dart';

import '../hooks/blockUser.dart';

class Users with ChangeNotifier {
  List<User>? _users = [];
  List<User>? _userConversations = [];
  String? authToken;
  double? lat;
  double? lon;

  Users(this.authToken, this.lat, this.lon, this._users, this._userConversations);

  List<User> get items {
    if (_users != null) {
      return [...?_users];
    }
    return [];
  }

  List<User>? get userConversations {
    if(_userConversations != null){
      return [...?_userConversations];
    }
    return [];
  }

  Future<UserDetails> getUserDetailsById(String id) async {
    final UserDetails userDetails = await fetchUserDetails(id, authToken!);
    return userDetails;
  }

  Future<void> getUserConversations() async {
    final List<User> conv = await getConversations(authToken!);
    _userConversations = conv;
    notifyListeners();
  }

  void addUserConversation(String email) async{
    await addConversation(email, authToken!);
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
