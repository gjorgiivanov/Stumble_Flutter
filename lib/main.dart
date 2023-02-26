import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:stumble/hooks/blockUser.dart';
import 'package:stumble/hooks/fetchNearbyUsers.dart';
import 'package:stumble/hooks/login.dart';
import 'package:stumble/hooks/register.dart';
import 'package:stumble/oauth/GoogleAuth.dart';
import 'package:stumble/screens/chat_screen.dart';

import 'hooks/fetchUserDetails.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Stumble',
      theme: ThemeData(
        primarySwatch: Colors.blue, primaryColor: Colors.lightBlueAccent[200],),
      home: const MyHomePage(),);
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(foregroundColor: Theme
        .of(context)
        .colorScheme
        .onPrimary,);
    return Scaffold(appBar: AppBar(title: const Text('Stumble Home Page'),
        actions: <Widget>[TextButton(style: style, onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatScreen()));
        }, child: const Text('Chat'),)
        ]), body: FloatingActionButton.small(onPressed: () {
      blockUser('tomegavazov2@gmail.com',
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InRvbWVnY'
              'XZhem92QGdtYWlsLmNvbSJ9.ApB8kTzXfHQTq-Xhcmc'
              'XfudIeiwL032EIwevthYHnDo');

    }));
  }
}
