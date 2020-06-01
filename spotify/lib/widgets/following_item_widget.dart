import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/user.dart';

class FollowingItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return ListTile(
      title: Text(
        user.name,
        style: TextStyle(color:Colors.white),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          user.images[0],
        ),
      ),
      subtitle: Text(
        user.following.length.toString() + " following",
        style: TextStyle(color:Colors.white),
      ),
      trailing: Icon(
        Icons.check,
        color: Colors.green,
      ),
    );
  }
}
