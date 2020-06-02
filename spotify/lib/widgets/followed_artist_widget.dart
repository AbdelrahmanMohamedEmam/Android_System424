import 'package:flutter/material.dart';

class FollowedArtistWidget extends StatefulWidget {
  @override
  _FollowedArtistWidgetState createState() => _FollowedArtistWidgetState();
}

class _FollowedArtistWidgetState extends State<FollowedArtistWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: 
        CircleAvatar(
          backgroundImage: NetworkImage('https://i.scdn.co/image/c4818b1f9d0c7a793d421b51c63d82c8c768795c'),
          radius: 40,
        ),
        title: Text(
          "Amr Diab",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
