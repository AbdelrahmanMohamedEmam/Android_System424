import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/playable_track.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/Albums/song_item_pop_up_menu.dart';
import 'package:spotify/Screens/MainApp/song_settings_screen.dart';
import '../Models/track.dart';

///It is used to provide the [PlaylistsListScreen] with the needed data about the track.
class AddSongToPlaylistItem extends StatefulWidget {
  String id;
  AddSongToPlaylistItem(this.id);
  @override
  _AddSongToPlaylistItemState createState() => _AddSongToPlaylistItemState();
}

class _AddSongToPlaylistItemState extends State<AddSongToPlaylistItem> {
  @override
  Widget build(BuildContext context) {
    final song = Provider.of<Track>(context, listen: false);
    final track = Provider.of<PlayableTrackProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    return Row(children: <Widget>[
      Container(
        width: deviceSize.width * 0.7,
        height: deviceSize.height * 0.1,
        child: InkWell(
          onTap: null,
          child: ListTile(
            leading: Image.network(song.album.image),
            title: Text(
              song.name,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              song.artists[0].name,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
      IconButton(
        icon: Icon(
          Icons.add_circle,
          color: Colors.white,
          size: 40,
        ),
        onPressed: ()  {
           Provider.of<PlaylistProvider>(context, listen: false)
              .fetchMoreRandomTracksForPlaylist(user.token, widget.id).then((_){
                print("lala");
              });
        },
      ),
    ]);
  }
}
