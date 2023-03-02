import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';
import '../providers/users.dart';
import 'chatList/chat_item.dart';
import 'chatList/chat_list.dart';

class ChatListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('My Messages')),
      body: Container(
        child: Column(
          children: [
            Expanded(child: ChatList())
          ],
        ),
      ),
    );
  }
}






