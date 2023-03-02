import 'package:flutter/material.dart';

class BlockConfirmationDialog extends StatelessWidget {
  final VoidCallback onBlockUser;

  const BlockConfirmationDialog({required this.onBlockUser});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure you want to block this user?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Block'),
          onPressed: onBlockUser,
        ),
      ],
    );
  }
}