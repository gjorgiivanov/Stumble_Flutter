import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/User.dart';

Future<List<User>> fetchNearbyUsers(double lat, double lon, String token) async {
  final response = await http
      .get(
      headers: <String, String>{
        'Authorization': token,
      },
      Uri.parse(
      'https://stumble-api.herokuapp.com/users/nearby/$lat/$lon'));

  if (response.statusCode == 200) {
    return List<Map<String, dynamic>>.from(jsonDecode(response.body))
        .map((e) => User.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load Users');
  }
}

