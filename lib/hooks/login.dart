import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stumble/models/LoginResponse.dart';
import 'package:stumble/models/UserDetails.dart';

Future<LoginResponse> login(String email, String password) async {
  final response = await http.post(
      Uri.parse('https://stumble-api.herokuapp.com/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email, 'password': password
      }));
  if(response.statusCode == 200){
    return LoginResponse(response.headers['authorization']!, UserDetails.fromJson(jsonDecode(response.body)));
  }else{
    throw Exception("Failed to authenticate user");
  }
}

