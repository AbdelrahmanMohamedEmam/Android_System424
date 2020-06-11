import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/track.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/widgets/add_song_to_playlist_widget.dart';

class AddSongToPlaylistScreen extends StatefulWidget {
 final  String playlistId;
  AddSongToPlaylistScreen(this.playlistId);
  @override
  _AddSongToPlaylistScreenState createState() =>
      _AddSongToPlaylistScreenState();
}

class _AddSongToPlaylistScreenState extends State<AddSongToPlaylistScreen> {
  UserProvider user;
  List<Track> randomTracks;
  PlaylistProvider playlistProvider;
  bool _isLoading = true;
  bool isInit = false;
  @override
  Future<void> didChangeDependencies() async {
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    user = Provider.of<UserProvider>(context);
    if (!isInit) {
      isInit = true;
      await Provider.of<PlaylistProvider>(context, listen: false)
          .fetchRandomTracksForPlaylist(user.token, widget.playlistId)
          .then((_) {
        setState(() {
          _isLoading = false;
          randomTracks = Provider.of<PlaylistProvider>(context, listen: false)
              .getRandomTracks;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading)
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text(
                'Add songs',
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: Container(
              width: double.infinity,
              child: ListView.builder(
                itemCount: randomTracks.length,
                itemBuilder: (context, i) => ChangeNotifierProvider.value(
                  value: randomTracks[i],
                  child: AddSongToPlaylistItem(widget.playlistId),
                ),
              ),
            ));
  }
}
