import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stumble/screens/chat_screen.dart';

import '../../models/User.dart';
import '../../providers/auth.dart';
import '../../providers/users.dart';
import '../../widgets/BlockConfirmationDialog.dart';
import 'chat_item.dart';

class ChatListItem extends StatefulWidget {
  final User user;

  const ChatListItem(this.user, {super.key});

  @override
  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {

  void _showBlockConfirmationDialog(String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlockConfirmationDialog(
          onBlockUser: () {
            Provider.of<Users>(context, listen: false).setBlockUser(email);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void tapHandler(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
            widget.user
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tapHandler,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.user.image),
      ),
      title: Row(
        children: [
          Text('${widget.user.firstName} ${widget.user.lastName}'),
            IconButton(
              icon: const Icon(Icons.block),
              onPressed: () => _showBlockConfirmationDialog(widget.user.email),
              iconSize: 15,
              padding: const EdgeInsets.all(0),
            ),
        ],
      ),
      subtitle: Text(widget.user.email),
      trailing: IconButton(
        onPressed: tapHandler,
        icon: const Icon(Icons.send),
      ),
    );
  }
}
