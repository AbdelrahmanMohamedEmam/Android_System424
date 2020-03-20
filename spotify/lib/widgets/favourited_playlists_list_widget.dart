import 'package:flutter/material.dart';
import '../Providers/playlist_provider.dart';
import 'package:provider/provider.dart';
import '../Models/playlist.dart';
import './favourited_playlist_widget.dart';

class FavouritedPlaylistsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playlistsProvider = Provider.of<PlaylistProvider>(context);
    List<Playlist> playlists;
    playlists = playlistsProvider.getMadeForYouPlaylists;
    String playlistName = "Daily Mix 1";
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            width: double.infinity,
            /*margin: EdgeInsets.only(
              bottom: 10,
              left: 5,
              top: 15,
            ),*/
          ),
          Container(
            height: 250,
            child: ListView.builder(
              itemCount: playlists.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: playlists[i],
                child: Row(
                  children: <Widget>[
                    Container(alignment: Alignment.topRight,
                      child: Text(
                        playlistName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        //textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      //padding: EdgeInsets.all(2),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: FavouritedPlaylist(),
                      height: 150,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
