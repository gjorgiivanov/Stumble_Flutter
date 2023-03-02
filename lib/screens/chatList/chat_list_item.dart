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
    return GestureDetector(
      onTap: tapHandler,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user.image),
                radius: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.user.firstName} ${widget.user.lastName}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.user.email,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.block),
                onPressed: () => _showBlockConfirmationDialog(widget.user.email),
                iconSize: 20,
                padding: const EdgeInsets.all(0),
                color: Colors.grey[700],
              ),
              IconButton(
                onPressed: tapHandler,
                icon: const Icon(Icons.send),
                color: Colors.blue[800],
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }

}
