import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../providers/users.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ref = FirebaseStorage.instance.ref().child("user_images");

  Future<ImageProvider?> _getImageUrl(String email) async {
    var img = ref.child(email + '.jpg');

    if (img.isBlank != null && !img.isBlank!) {
      var downloadUrl = await img.getDownloadURL();
      return NetworkImage(downloadUrl);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<Users>(context).items;

    return ListView.builder(
      itemCount: usersData.length,
      itemBuilder: (BuildContext context, int index) {
        final user = usersData[index];
        return ListTile(
          leading: FutureBuilder(
            future: _getImageUrl(user.email),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return CircleAvatar(
                radius: 30,
                backgroundImage: snapshot.data,
                child: Text(
                  user.firstName,
                ),
              );
            },
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
