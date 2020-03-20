import 'package:flutter/material.dart';
import 'package:spotify/widgets/favourited_playlist_widget.dart';
import '../../Providers/playlist_provider.dart';
import 'package:provider/provider.dart';
import '../../Models/playlist.dart';
import '../../widgets/favourited_playlists_list_widget.dart';

class PlaylistsScreen extends StatelessWidget {
  void createPlaylistButton() {
    print('button pressed');
  }

  @override
  Widget build(BuildContext context) {
    final playlistsProvider = Provider.of<PlaylistProvider>(context);
    List<Playlist> playlists;
    playlistsProvider.fetchMadeForYouPlaylists();
    playlists = playlistsProvider.getMadeForYouPlaylists;
    print('hello');
    print(playlists[0].name);
    String image =
        "https://dailymix-images.scdn.co/v1/img/ab67616d0000b273cfa4e906cda39d8f62fe81e3/1/en/default";
    String playlistName = "Daily Mix 1";
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
              child: ListView.builder(itemBuilder:(context, i)=> FavouritedPlaylist(),itemCount: playlists.length,)
                /* FlatButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.add_box,
                  color: Colors.grey,
                  size: 70,
                ),
                label: Text(
                  'Create playlist',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),*/

                // Padding(padding: EdgeInsets.all(5)),
                /*FlatButton.icon(
                onPressed: () {},
                icon: Container(
                  child: FadeInImage(
                    image: NetworkImage(image),
                    placeholder: AssetImage('assets/images/temp.jpg'),
                    width: 60,
                    height: 60,
                    //alignment: Alignment.topRight,
                  ),
                ),
                label: Text(
                  playlistName,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),

                //FavouritedPlaylistsList(),
              ),
              Padding(padding: EdgeInsets.all(5)),
              FlatButton.icon(
                onPressed: () {},
                icon: Container(
                  child: FadeInImage(
                    image: NetworkImage(image),
                    placeholder: AssetImage('assets/images/temp.jpg'),
                    width: 60,
                    height: 60,
                    //alignment: Alignment.topRight,
                  ),
                ),
                label: Text(
                  playlistName,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),

                //FavouritedPlaylistsList(),
              ),
              Padding(padding: EdgeInsets.all(5)),
              FlatButton.icon(
                onPressed: () {},
                icon: Container(
                  child: FadeInImage(
                    image: NetworkImage(image),
                    placeholder: AssetImage('assets/images/temp.jpg'),
                    width: 60,
                    height: 60,
                    //alignment: Alignment.topRight,
                  ),
                ),
                label: Text(
                  playlistName,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),

                //FavouritedPlaylistsList(),
              ),
              Padding(padding: EdgeInsets.all(5)),
              FlatButton.icon(
                onPressed: () {},
                icon: Container(
                  child: FadeInImage(
                    image: NetworkImage(image),
                    placeholder: AssetImage('assets/images/temp.jpg'),
                    width: 60,
                    height: 60,
                    //alignment: Alignment.topRight,
                  ),
                ),
                label: Text(
                  playlistName,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),*/
              
            ),
          ],
        ),
      ),
    );
  }
}
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
