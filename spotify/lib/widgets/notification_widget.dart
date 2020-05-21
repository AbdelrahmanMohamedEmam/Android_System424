import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/notification.dart';

class NotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notification = Provider.of<Notifications>(context);
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundColor: Color.fromRGBO(27, 255, 138, 1),
      ),
      title: Text(
        notification.title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        notification.body,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
