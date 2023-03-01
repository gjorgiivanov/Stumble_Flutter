import 'package:flutter/material.dart';
import 'package:stumble/widgets/chat/messages.dart';
import 'package:stumble/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  final String email1;
  final String email2;

  const ChatScreen({Key? key, required this.email1, required this.email2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(email1: email1, email2: email2),
            ),
            NewMessage(email1: this.email1, email2: this.email2),
          ],
        ),
      ),
    );
  }
}
