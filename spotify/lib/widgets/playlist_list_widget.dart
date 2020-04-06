//import packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import providers
import '../Providers/playlist_provider.dart';
//import widgets
import '../widgets/playlist_item_widget.dart';
import '../Models/playlist.dart';

class PlaylistList extends StatelessWidget {
  final String categoryTitle;

  PlaylistList(this.categoryTitle);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final playlistsProvider = Provider.of<PlaylistProvider>(context);
    List<Playlist> playlists;
    if (categoryTitle == 'Popular playlists') {
      playlists = playlistsProvider.getPopularPlaylists;
    } else if (categoryTitle == 'Most recent playlists') {
      playlists = playlistsProvider.getMostRecentPlaylists;
    } else if (categoryTitle == 'Pop') {
      playlists = playlistsProvider.getpopPlaylists;
    } else if (categoryTitle == 'Jazz') {
      playlists = playlistsProvider.getJazzPlaylists;
    }

    return Container(
      height: (deviceSize.height) * 0.3880,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            height: ((deviceSize.height) * 0.4) * 0.14,
            width: double.infinity,
            margin: EdgeInsets.only(
              bottom: ((deviceSize.height) * 0.4) * 0.0357,
              left: deviceSize.width * 0.0244,
              top: ((deviceSize.height) * 0.4) * 0.0535,
            ),
            child: Text(
              categoryTitle,
              style: TextStyle(
                color: Color.fromRGBO(196, 189, 187, 20),
                fontSize: deviceSize.width * 0.0609,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: (deviceSize.height) * 0.2929,
            child: ListView.builder(
              itemCount: playlists.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: playlists[i],
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: deviceSize.width * 0.0244,
                  ),
                  child: PlaylistWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
