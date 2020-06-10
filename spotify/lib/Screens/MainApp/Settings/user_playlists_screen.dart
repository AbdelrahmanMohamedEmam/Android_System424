import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/playlist.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/widgets/created_playlist_widget.dart';

class UserPlaylistsScreen extends StatefulWidget {
  @override
  _UserPlaylistsScreenState createState() => _UserPlaylistsScreenState();
}

class _UserPlaylistsScreenState extends State<UserPlaylistsScreen> {
  List<Playlist> createdPlaylists;
  @override
  void didChangeDependencies() {
    final playlists = Provider.of<PlaylistProvider>(context, listen: false);
    createdPlaylists = playlists.getCreatedPlaylists;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 2),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(48, 44, 44, 1),
        centerTitle: true,
        title: Text(
          'Playlists',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
        height: deviceSize.height*0.806,
        child: ListView.builder(
          itemCount: createdPlaylists.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, i) => ChangeNotifierProvider.value(
            value: createdPlaylists[i],
            child: CreatedPlaylistWidget(createdPlaylists[i].id),
          ),
        ),
      ),
    );
  }
}
