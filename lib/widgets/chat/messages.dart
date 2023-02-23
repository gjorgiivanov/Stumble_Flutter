import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stumble/widgets/chat/message_bubble.dart';

import '../../data/constants.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

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
        stream: FirebaseFirestore.instance
            .collection('chats/so5264bjiTtfTbdT1TMr/messages')
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
                      user: documents![index]['userId'] == me.id ? me : other,
                      message: documents![index]['text'],
                      isMe: documents![index]['userId'] == me.id,
                      key: ValueKey(documents![index].reference.id),
                    ),
                  ));
        },
      ),
    );
  }
}
