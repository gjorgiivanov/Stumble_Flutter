import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import '../data/constants.dart';
import '../providers/auth.dart';
import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;

  Future<void> _submitAuthForm(
    String email,
    String password,
    String firstName,
    String lastName,
    File? image,
    Gender? gender,
    bool isLogin,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        await Provider.of<Auth>(context, listen: false).login(
          email,
          password,
        );
      } else {
        if (image != null && gender != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child("user_images")
              .child(email + path.extension(image.path));
          await ref.putFile(image);

          var imageUrl = await ref.getDownloadURL();

          await Provider.of<Auth>(context, listen: false).register(
            firstName,
            lastName,
            imageUrl,
            gender,
            email,
            password,
            '',
            '',
            '',
            '',
          );
        }
      }
      //until login logic implemented
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
