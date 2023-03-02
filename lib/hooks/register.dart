import 'dart:io';

import 'package:http/http.dart' as http;

import '../data/constants.dart';

Future<http.StreamedResponse> register(
    String firstName,
    String lastName,
    String image,
    Gender gender,
    String email,
    String password,
    String description,
    String instagramAccount,
    String facebookAccount,
    String linkedinAccount,
    ) async {
  final url = Uri.parse('http://stumble-api.herokuapp.com/register');
  final request = http.MultipartRequest('POST', url);

  request.fields['firstName'] = firstName;
  request.fields['lastName'] = lastName;
  request.fields['gender'] = gender.toString().split('.').last;
  request.fields['email'] = email;
  request.fields['password'] = password;
  request.fields['description'] = description;
  request.fields['instagramAccount'] = instagramAccount;
  request.fields['facebookAccount'] = facebookAccount;
  request.fields['linkedinAccount'] = linkedinAccount;
  request.fields['image'] = image;

  return await request.send();
}
