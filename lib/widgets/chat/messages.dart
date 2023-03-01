import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stumble/widgets/chat/message_bubble.dart';

import 'package:crypto/crypto.dart';
import '../../data/constants.dart';
class Messages extends StatefulWidget {
  final String email1;
  final String email2;

  const Messages({Key? key, required this.email1, required this.email2}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late String chatId;
  late CollectionReference messagesCollectionRef;

  @override
  void initState() {
    super.initState();
    chatId = generateKey(widget.email1, widget.email2);
    messagesCollectionRef =
        FirebaseFirestore.instance.collection('chats/$chatId/messages');
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
          .doc(chatId)
          .set({'created_at': DateTime.now()});
    }
  }

  static String generateKey(String email1, String email2) {
    String data;
    if (email1.compareTo(email2) > 1) {
      data = email1 + email2;
    } else {
      data = email2 + email1;
    }
    var bytes = utf8.encode(data);
    String hash = sha256.convert(bytes).toString();
    print(hash);
    return hash;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${other.firstName} ${other.lastName}"),
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
                      user: documents![index]['userEmail'] == me.id ? me : other,
                      message: documents![index]['text'],
                      isMe: documents![index]['userEmail'] == widget.email1,
                      key: ValueKey(documents![index].reference.id),
                    ),
                  ));
        },
      ),
    );
  }
}
