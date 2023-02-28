import 'package:flutter/material.dart';
import 'package:stumble/models/User.dart';

class UserList extends StatefulWidget {
  final List<User> users;

  UserList({required this.users});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.users.map((user) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(user.firstName[0]),
            ),
            title: Text(user.firstName + ' ' + user.lastName),
            subtitle: Row(
              children: [Icon(Icons.info), Icon(Icons.block), Icon(Icons.chat)],
            ),
            onTap: () {
              // navigate to user details page
            },
          ),
        );
      }).toList(),
    );
  }
}
