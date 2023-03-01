import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/User.dart';

Future<List<User>> fetchNearbyUsers(int id, double lat, double lon) async {
  final response = await http
      .get(Uri.parse(
      'https://stumble-api.herokuapp.com/users/nearby/$id/$lat/$lon'));

  if (response.statusCode == 200) {
    return List<Map<String, dynamic>>.from(jsonDecode(response.body))
        .map((e) => User.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load Users');
  }
}

