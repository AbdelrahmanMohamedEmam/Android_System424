import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/playable_track.dart';
import '../Models/track.dart';

class SongItemPlaylistList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final song = Provider.of<Track>(context, listen: false);
    final track = Provider.of<PlayableTrackProvider>(context, listen: false);

    //String artistName = "Maitre";
    return InkWell(
      onTap: () {
        track.setCurrentSong(song);
      },
      child: ListTile(
        leading: Image.network(song.album.images[0]),
        title: Text(
          song.name,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          song.artists[0].name,
          style: TextStyle(color: Colors.grey),
        ),
        trailing: Wrap(
          spacing: 3,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
              color: Colors.white,
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
