import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stumble/widgets/chat/messages.dart';
import 'package:stumble/widgets/chat/new_message.dart';

import '../models/User.dart';
import '../providers/auth.dart';
import 'chatList/chat_item.dart';

class ChatScreen extends StatelessWidget {
  final User user;

  const ChatScreen(this.user);

  String generateKey(String email1, String email2) {
    String data;
    if (email1.compareTo(email2) > 0) {
      data = email1 + email2;
    } else {
      data = email2 + email1;
    }
    var bytes = utf8.encode(data);
    String hash = sha256.convert(bytes).toString();
    return hash;
  }

  @override
  Widget build(BuildContext context) {
    String sender = Provider.of<Auth>(context, listen:false).userId!;
    String chatId = generateKey(sender, user.email);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(chatId, sender, user),
            ),
            NewMessage(generateKey(sender, user.email), sender),
          ],
        ),
      ),
    );
  }
}
