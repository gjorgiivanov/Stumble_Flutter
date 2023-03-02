import 'package:flutter/material.dart';

import 'chatList/chat_list.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Messages')),
      body: Container(
        child: Column(
          children: const [
            Expanded(
              child: ChatList(),
            )
          ],
        ),
      ),
    );
  }
}
