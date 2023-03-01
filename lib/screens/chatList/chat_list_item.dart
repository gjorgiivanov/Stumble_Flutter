import 'package:flutter/material.dart';
import 'package:stumble/screens/chat_screen.dart';

import 'chat_item.dart';

class ChatListItem extends StatefulWidget {
  final ChatItem item;

  const ChatListItem({required this.item});

  @override
  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  bool _isBlocked = false;

  void _showBlockConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to block this user?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Block'),
              onPressed: () {
                // Perform block user action
                setState(() {
                  _isBlocked = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.item.imageUrl),
      ),
      title: Row(
        children: [
          Text('${widget.item.name} ${widget.item.surname}'),
          if (!_isBlocked)
            IconButton(
              icon: Icon(Icons.block),
              onPressed: _showBlockConfirmationDialog,
              iconSize: 15,
              padding: EdgeInsets.all(0),
            ),
        ],
      ),
      subtitle: Text(widget.item.email),
      trailing: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatScreen(
                email1: "tom@gmail.com",
                email2: "tom2@gmail.com",
              ),
            ),
          );
        },
        icon: Icon(Icons.send),
      ),
    );
  }
}
