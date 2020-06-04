import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/user.dart';

import 'package:spotify/Providers/user_provider.dart';

class FollowersItemWidget extends StatefulWidget {
  @override
  _FollowersItemWidgetState createState() => _FollowersItemWidgetState();
}

class _FollowersItemWidgetState extends State<FollowersItemWidget> {
  bool following;
  UserProvider userProvider;
  User user;
  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    //following = userProvider.isFollowed(user.id);
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
          try {
            setState(() async {
              userProvider.isFollowed(user.id)
                  ? await userProvider.unfollow(user.id)
                  : await userProvider.follow(user.id);
              userProvider.isFollowed(user.id)
                  ? _showErrorDialog("Followed successfully")
                  : _showErrorDialog("unfollowed successfully");
            });
          } catch (error) {
            //_showErrorDialog("Something went wrong!!");
          }
        },
        child: Icon(
          Icons.check,
          color: userProvider.isFollowed(user.id) ? Colors.green : Colors.white,
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Message"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
