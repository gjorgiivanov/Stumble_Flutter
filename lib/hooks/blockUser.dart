import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stumble/models/UserDetails.dart';

void blockUser(int userId, blockUserId) async {
  await http.post(
      Uri.parse('https://stumble-api.herokuapp.com/users/block'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
           'userId': userId, 'blockUserId': blockUserId
  }));
}

