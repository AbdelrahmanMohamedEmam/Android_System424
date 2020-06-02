import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/user.dart';
import 'package:spotify/Providers/user_provider.dart';

class FollowersItemWidget extends StatefulWidget {
  @override
  _FollowersItemWidgetState createState() => _FollowersItemWidgetState();
}

class _FollowersItemWidgetState extends State<FollowersItemWidget> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
        user.followers.length.toString() + " followers",
        style: TextStyle(color: Colors.white),
      ),
      trailing: GestureDetector(
        onTap: () {
          // userProvider.isFollowed(user.id)
          //     ? userProvider.unfollow(user.id)
          //     : userProvider.follow(user.id);
        },
        child: Icon(
          Icons.check,
          color: Colors
              .green, //userProvider.isFollowed(user.id) ? Colors.green : Colors.white,
        ),
      ),
    );
  }
}
