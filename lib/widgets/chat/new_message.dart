
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class NewMessage extends StatefulWidget {
  final String chatId;
  final String sender;

  const NewMessage(this.chatId, this.sender, {super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = TextEditingController();

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance
        .collection('/chats/${widget.chatId}/messages')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userEmail': (widget.sender),
      //send a message from a random user with id of 5 or 6
    });
    _enteredMessage = '';
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
