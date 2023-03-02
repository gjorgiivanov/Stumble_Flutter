import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:stumble/screens/chatList/chat_item.dart';
import 'package:stumble/widgets/chat/message_bubble.dart';

import '../../data/constants.dart';
import '../../models/User.dart';

class Messages extends StatefulWidget {
  final String chatId;
  final String sender;
  final User user;

  const Messages(this.chatId, this.sender, this.user, {super.key});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late CollectionReference messagesCollectionRef;

  @override
  void initState() {
    super.initState();
    messagesCollectionRef =
        FirebaseFirestore.instance.collection('chats/${widget.chatId}/messages');
    checkOrCreateCollection();
  }

  Future<void> checkOrCreateCollection() async {
    try {
      await messagesCollectionRef
          .doc('test_doc')
          .set({'test_field': 'test_value'});
    } catch (error) {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .set({'created_at': DateTime.now()});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.firstName} ${widget.user.lastName}"),
        leading: const BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: messagesCollectionRef
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data?.docs;
          return ListView.builder(
              reverse: true,
              itemCount: documents != null ? documents.length : 0,
              itemBuilder: (ctx, index) => Container(
                    padding: const EdgeInsets.all(8),
                    child: MessageBubble(
                      user:
                          documents![index]['userEmail'] == widget.sender ?
                          me : widget.user,
                      message: documents![index]['text'],
                      isMe: documents![index]['userEmail'] == widget.sender,
                      key: ValueKey(documents![index].reference.id),
                    ),
                  ));
        },
      ),
    );
  }
}
