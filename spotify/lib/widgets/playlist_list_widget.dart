//import packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/user_provider.dart';
//import providers
import '../Providers/playlist_provider.dart';
//import widgets
import '../widgets/playlist_item_widget.dart';
import '../Models/playlist.dart';

class PlaylistList extends StatelessWidget {
  final PlaylistCategory playlistType;
  String categoryTitle;
  PlaylistList(this.playlistType);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final playlistsProvider = Provider.of<PlaylistProvider>(context);
    final user = Provider.of<UserProvider>(context, listen: false);
    List<Playlist> playlists;

    if (playlistType == PlaylistCategory.popularPlaylists) {
      categoryTitle = 'Popular playlists';
      playlists = playlistsProvider.getPopularPlaylists;
    } else if (playlistType == PlaylistCategory.mostRecentPlaylists) {
      categoryTitle = 'Most recent playlists';
      playlists = playlistsProvider.getMostRecentPlaylists;
    } else if (playlistType == PlaylistCategory.pop) {
      categoryTitle = 'Pop';
      playlists = playlistsProvider.getpopPlaylists;
    } else if (playlistType == PlaylistCategory.jazz) {
      categoryTitle = 'Jazz';
      playlists = playlistsProvider.getJazzPlaylists;
    } else if (playlistType == PlaylistCategory.arabic) {
      categoryTitle = 'Arabic';
      playlists = playlistsProvider.getArabicPlaylists;
    } else if (playlistType == PlaylistCategory.happy) {
      categoryTitle = 'Happy';
      playlists = playlistsProvider.getHappyPlaylists;
    } else if (playlistType == PlaylistCategory.madeForYou) {
      categoryTitle = 'MadeForYou';
      playlists = playlistsProvider.getMadeForYou;
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
                  child: PlaylistWidget(
                    playlistType: playlistType,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
