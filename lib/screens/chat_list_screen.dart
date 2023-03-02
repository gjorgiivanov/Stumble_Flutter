import 'package:flutter/material.dart';

import 'chatList/chat_item.dart';
import 'chatList/chat_list.dart';

class ChatListScreen extends StatelessWidget {
  final List<ChatItem> chatItems = [
    ChatItem(
        name: 'John',
        surname: 'Doe',
        email: 'john.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),
    ChatItem(
        name: 'Jane',
        surname: 'Doe',
        email: 'jane.doe@example.com',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c2/Johnny_Cash_1977.jpg'),

    // Add more chat items as needed
  ];

  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Messages')),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ChatList(items: chatItems),
            )
          ],
        ),
      ),
    );
  }
}
