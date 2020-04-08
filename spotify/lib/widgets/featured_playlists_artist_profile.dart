import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Screens/Playlists/playlists_list_screen.dart';
import '../Models/playlist.dart';

class FeaturedPlaylists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlist>(context);
    return InkWell(
      onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlaylistsListScreen(playlistId:  playlist.id,playlistType: PlaylistCategory.artist, )));},
      child: Card(
        elevation: 20,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Image.network(
                playlist.images[0],
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
            Text(playlist.name,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
