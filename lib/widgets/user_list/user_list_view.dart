import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stumble/screens/chat_screen.dart';
import 'package:stumble/providers/users.dart';

import '../BlockConfirmationDialog.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<Users>(context, listen: true).items;

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

    return ListView.builder(
      itemCount: usersData.length,
      itemBuilder: (BuildContext context, int index) {
        final user = usersData[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 4,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.image),
            ),
            title: Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.info_outline),
                const SizedBox(width: 8),
                GestureDetector(
                  child: Icon(Icons.block, color: Colors.grey),
                  onTap: () {
                    _showBlockConfirmationDialog(user.email);
                  },
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  child: Icon(Icons.chat_bubble_outline, color: Colors.grey),
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
          ),
        );
      },
    );
  }
}
