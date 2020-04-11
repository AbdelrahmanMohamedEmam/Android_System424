import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/playable_track.dart';
import '../Models/track.dart';

///It is used to provide the [PlaylistsListScreen] with the needed data about the track.

class SongItemPlaylistList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final song = Provider.of<Track>(context, listen: false);
    final track = Provider.of<PlayableTrackProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        track.setCurrentSong(song);
      },
      child: ListTile(
        leading: Image.network(
            song.album.image),
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
              icon: Icon(
                Icons.favorite_border,
                color: Colors.white54,
              ),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white54,
              ),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
