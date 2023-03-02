import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> blockUser(String email, String token) async {
  await http.post(
    Uri.parse('https://stumble-api.herokuapp.com/users/block'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    },
    body: jsonEncode(
      <String, dynamic>{'blockUserEmail': email},
    ),
  );
}
