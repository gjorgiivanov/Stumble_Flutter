import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stumble/oauth/LoginController.dart';

class GoogleAuth extends StatelessWidget {
  final controller = Get.put(LoginController());

  GoogleAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await GoogleSignIn().signIn();

      },
      label: Text("Log In with your Google Account"),
    );
  }
}
