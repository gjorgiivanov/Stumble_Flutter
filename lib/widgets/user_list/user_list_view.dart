import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/users.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<Users>(context).items;

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
            children: const [
              Icon(Icons.info),
              Icon(Icons.block),
              Icon(Icons.chat)
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
