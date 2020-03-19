//import packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import providers
import '../Providers/album_provider.dart';
//import widgets
import '../widgets/album_item_widget.dart';
import '../Models/album.dart';

class AlbumList extends StatelessWidget {
  final String categoryTitle;

  AlbumList(this.categoryTitle);
  @override
  Widget build(BuildContext context) {
    final albumsProvider = Provider.of<AlbumProvider>(context);
    List<Album> albums;
    albums = albumsProvider.getPopularAlbums;

    // if (categoryTitle == 'Popular playlists') {
    //   playlists = playlistsProvider.getPopularPlaylists;
    // } else if (categoryTitle == 'Made for you') {
    //   playlists = playlistsProvider.getMadeForYouPlaylists;
    // }

    return Container(
      height: 280,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            width: double.infinity,
            margin: EdgeInsets.only(
              bottom: 10,
              left: 5,
              top: 15,
            ),
            child: Text(
              categoryTitle,
              style: TextStyle(
                color: Color.fromRGBO(196, 189, 187, 20),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 215,
            child: ListView.builder(
              itemCount: albums.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: albums[i],
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: AlbumWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
