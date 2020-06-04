import 'package:flutter/material.dart';
import 'package:spotify/Models/artist.dart';

class FollowedArtistWidget extends StatefulWidget {
  Artist followedArtist;
  FollowedArtistWidget(this.followedArtist);
  @override
  _FollowedArtistWidgetState createState() => _FollowedArtistWidgetState();
}

class _FollowedArtistWidgetState extends State<FollowedArtistWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.followedArtist.images[0]),
          radius: 25,
        ),
        title: Text(
          widget.followedArtist.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
