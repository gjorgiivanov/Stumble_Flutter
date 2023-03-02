import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stumble/screens/chat_screen.dart';

import '../../models/User.dart';
import '../../providers/auth.dart';
import 'chat_item.dart';

class ChatListItem extends StatefulWidget {
  final User user;

  const ChatListItem(this.user, {super.key});

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
          title: const Text('Are you sure you want to block this user?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Block'),
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
        backgroundImage: NetworkImage(widget.user.image),
      ),
      title: Row(
        children: [
          Text('${widget.user.firstName} ${widget.user.lastName}'),
          if (!_isBlocked)
            IconButton(
              icon: const Icon(Icons.block),
              onPressed: _showBlockConfirmationDialog,
              iconSize: 15,
              padding: const EdgeInsets.all(0),
            ),
        ],
      ),
      subtitle: Text(widget.user.email),
      trailing: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                widget.user
              ),
            ),
          );
        },
        icon: const Icon(Icons.send),
      ),
    );
  }
}
