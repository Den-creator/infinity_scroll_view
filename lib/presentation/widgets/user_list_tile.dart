import 'package:flutter/material.dart';

import '../../data/model/user.dart';
import '../../constants.dart';

class UserListTile extends StatelessWidget {
  final User user;

  const UserListTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        user.name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(user.email, style: const TextStyle(color: Colors.white)),
      tileColor: user.gender == Gender.female
          ? k.pinkColor
          : Theme.of(context).primaryColor.withAlpha(200),
    );
  }
}
