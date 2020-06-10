import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/user.dart';
import 'package:spotify/Providers/user_provider.dart';

class FollowingItemWidget extends StatefulWidget {
  
  @override
  _FollowingItemWidgetState createState() => _FollowingItemWidgetState();
}

class _FollowingItemWidgetState extends State<FollowingItemWidget> {
      bool followed = true;
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
        user.followers.length.toString() + " followers",
        style: TextStyle(color: Colors.white),
      ),
      trailing: GestureDetector(
        onTap: () {
          try {
            userProvider.unfollow(user.id);
            setState(() {
              followed = false;
            });
            _showErrorDialog("Unfollowed successfully!!");
          } catch (error) {
            _showErrorDialog("Something went wrong!!");
          }
        },
        child: Icon(
          Icons.check,
          color: followed ? Colors.green : Colors.white,
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
            },
          )
        ],
      ),
    );
  }
}
