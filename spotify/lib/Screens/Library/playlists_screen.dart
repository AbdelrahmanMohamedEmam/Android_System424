import 'package:flutter/material.dart';
import 'package:spotify/widgets/favourited_playlist_widget.dart';
import '../../Providers/playlist_provider.dart';
import 'package:provider/provider.dart';
import '../../Models/playlist.dart';

class PlaylistsScreen extends StatelessWidget {
  void createPlaylistButton() {
    print('button pressed');
  }

  @override
  Widget build(BuildContext context) {
    final playlistsProvider = Provider.of<PlaylistProvider>(context);
    List<Playlist> playlists;
    playlists = playlistsProvider.getMadeForYouPlaylists;
    print('hello');
    print(playlists[0].name);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: 400,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              height: 350,
              child: ListView.builder(
                  itemCount: playlists.length,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                        value: playlists[i],
                        child: FavouritedPlaylist(),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
///////////////This part will be added later to create a playlist for the first timt

/*child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Create your first playlist',
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.all(3)),
              Text(
                'It\'s easy\',we\'ll help you.',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.all(10)),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
                onPressed: createPlaylistButton,
                child: Text(
                  'CREATE PLAYLIST',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
              )
            ],
          ),*/
