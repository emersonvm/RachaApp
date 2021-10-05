import 'package:flutter/material.dart';

import 'package:racha_app/pages/user.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatar == null || user.avatar.isEmpty
        ? CircleAvatar(child: Icon(Icons.event_available, size: 50.0))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatar));
    return ListTile(
      leading: avatar,
      title: Text(user.name,
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_forever_rounded, size: 50.0),
              color: Colors.red,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
