import 'dart:io';

import 'package:http/http.dart' as http;

Future<void> register(
  String firstName,
  String lastName,
  File image,
  String gender,
  String email,
  String password,
  String description,
  String instagramAccount,
  String facebookAccount,
  String linkedinAccount,
) async {
  final url = Uri.parse('http://stumble-api.herokuapp.com/register');
  final request = http.MultipartRequest('POST', url);

  // Add fields
  request.fields['firstName'] = firstName;
  request.fields['lastName'] = lastName;
  request.fields['gender'] = gender;
  request.fields['email'] = email;
  request.fields['password'] = password;
  request.fields['description'] = description;
  request.fields['instagramAccount'] = instagramAccount;
  request.fields['facebookAccount'] = facebookAccount;
  request.fields['linkedinAccount'] = linkedinAccount;

  // Add image file
  if (image != null) {
    final stream = http.ByteStream(image.openRead());
    final length = await image.length();
    final multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
      filename: image.path.split('/').last,
    );
    request.files.add(multipartFile);
  }

  final response = await request.send();
  print(response);
}
