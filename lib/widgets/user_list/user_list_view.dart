import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stumble/screens/chat_screen.dart';

import '../../providers/users.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<Users>(context, listen: true).items;

    return ListView.builder(
      itemCount: usersData.length,
      itemBuilder: (BuildContext context, int index) {
        final user = usersData[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(user.image),
            child: Text(
              user.firstName,
            ),
          ),
          title: Text('${user.firstName} ${user.lastName}'),
          subtitle: Row(
            children: [
              Icon(Icons.info),
              GestureDetector(
                child: Icon(Icons.block),
                onTap: () {
                  Provider.of<Users>(context, listen: false)
                      .setBlockUser(user.email);
                },
              ),
              GestureDetector(
                child: Icon(Icons.chat),
                onTap: () {
                  Provider.of<Users>(context, listen: false)
                      .addUserConversation(user.email);
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (context) => ChatScreen(user)),
                  );
                },
              ),
            ],
          ),
          onTap: () {
            // navigate to user details page
          },
        );
      },
    );
  }
}


