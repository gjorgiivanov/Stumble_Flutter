import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String firstName,
    String lastName,
    File? image,
    bool isLogin,
  ) {
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        //todo: login a user
      } else {
        //todo: create new user
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
