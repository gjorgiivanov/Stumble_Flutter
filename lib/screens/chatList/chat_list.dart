
import 'package:flutter/material.dart';

import 'chat_item.dart';
import 'chat_list_item.dart';

class ChatList extends StatefulWidget {
  final List<ChatItem> items;

  ChatList({required this.items});

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = widget.items[index];
        return ChatListItem(
          item: item,
        );
      },
    );
  }
}