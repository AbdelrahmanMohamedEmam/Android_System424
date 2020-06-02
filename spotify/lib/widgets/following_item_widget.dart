import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/user.dart';
import 'package:spotify/Providers/user_provider.dart';

class FollowingItemWidget extends StatefulWidget {
  @override
  _FollowingItemWidgetState createState() => _FollowingItemWidgetState();
}

class _FollowingItemWidgetState extends State<FollowingItemWidget> {
  Color color = Colors.green;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return ListTile(
      title: Text(
        user.name,
        style: TextStyle(color: Colors.white),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          user.images[0],
        ),
      ),
      subtitle: Text(
        user.following.length.toString() + " following",
        style: TextStyle(color: Colors.white),
      ),
      trailing: GestureDetector(
        onTap: () {
          //userProvider.unfollow(user.id);
        },
        child: Icon(
          Icons.check,
          color: color,
        ),
      ),
    );
  }
}
