import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stumble/providers/users.dart';
import 'package:stumble/widgets/user_list/user_list_view.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  void didChangeDependencies() {
    if (mounted) {
      Provider.of<Users>(context, listen: false).getNearbyUsers();
      Timer.periodic(
        Duration(minutes: 5),
        (Timer t) =>
            Provider.of<Users>(context, listen: false).getNearbyUsers(),
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return UserList();
  }
}
