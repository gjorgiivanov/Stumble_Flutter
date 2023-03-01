import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stumble/models/UserDetails.dart';

Future<UserDetails> fetchUserDetails(String email, String token) async {
  final response = await http
      .get(
      headers: <String, String>{
        'Authorization': token,
      },
      Uri.parse('https://stumble-api.herokuapp.com/users/$email'));

  if (response.statusCode == 200) {
    return UserDetails.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load User');
  }
}

