//import packages
import 'package:flutter/material.dart';
//import providers
import 'package:provider/provider.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Screens/Playlists/created_playlist_screen.dart';
//import models
import '../Models/playlist.dart';

///It is used to provide the [PlaylistScreen] with the needed data about the track.
class CreatedPlaylistWidget extends StatefulWidget {
 final  String id;
  CreatedPlaylistWidget(this.id);
  @override
  _CreatedPlaylistWidgetState createState() => _CreatedPlaylistWidgetState();
}

class _CreatedPlaylistWidgetState extends State<CreatedPlaylistWidget> {
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlist>(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreatedPlaylistScreen(widget.id),
          ),
        );
      },
      child: ListTile(
        //leading: Image.network(playlist.images[0]),
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
