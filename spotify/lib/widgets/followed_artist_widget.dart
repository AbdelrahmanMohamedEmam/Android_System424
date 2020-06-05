import 'package:flutter/material.dart';
import 'package:spotify/Models/artist.dart';
import 'package:spotify/Screens/ArtistProfile/artist_profile_screen.dart';

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
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ArtistProfileScreen(
              id: widget.followedArtist.id,
            ),
          ),
        );
      },
      child: ListTile(
        leading: ClipRRect(
          child: FadeInImage(
            placeholder: AssetImage('assets/images/artist.jpg'),
            image: NetworkImage(widget.followedArtist.images[0]),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        title: Text(
          widget.followedArtist.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
