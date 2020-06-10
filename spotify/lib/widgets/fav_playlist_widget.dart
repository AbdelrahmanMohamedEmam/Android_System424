//import packages
import 'package:flutter/material.dart';
//import providers
import 'package:provider/provider.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Screens/Playlists/playlists_list_screen.dart';
//import models
import '../Models/playlist.dart';

///It is used to provide the [PlaylistScreen] with the needed data about the track.
class FavPlaylistWidget extends StatefulWidget {
  final PlaylistCategory category;
  final String id;
  FavPlaylistWidget(this.category, this.id);

  @override
  _FavPlaylistWidgetState createState() => _FavPlaylistWidgetState();
}

class _FavPlaylistWidgetState extends State<FavPlaylistWidget> {
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlist>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlaylistsListScreen(
              playlistId: widget.id,
              playlistType: widget.category,
            ),
          ),
        );
      },
      child: ListTile(
        leading: FadeInImage(
          placeholder: AssetImage('assets/images/temp.jpg'),
          image: NetworkImage(playlist.images[0]),
          fit: BoxFit.fill,
        ),
        title: Text(
          playlist.name,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          playlist.owner[0].name,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
