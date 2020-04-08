//import packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import providers
import '../Providers/album_provider.dart';
//import widgets
import '../widgets/album_item_widget.dart';
import '../Models/album.dart';

class AlbumList extends StatelessWidget {//
  String categoryTitle;
  AlbumCategory albumCategory;
  AlbumList(this.albumCategory);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final albumsProvider = Provider.of<AlbumProvider>(context);
    List<Album> albums;
    if (albumCategory == AlbumCategory.mostRecentAlbums) {
      categoryTitle = 'Most recent albums';
      albums = albumsProvider.getPopularAlbums;
    } else if (albumCategory == AlbumCategory.popularAlbums) {
      categoryTitle = 'Popular Albums';
      albums = albumsProvider.getMostRecentAlbums;
    }
    print("enta gebt el albums sa7");
print(albums);
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
              itemCount: albums.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: albums[i],
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: deviceSize.width * 0.0244,
                  ),
                  
                  child: AlbumWidget(
                    albumCategory: albumCategory,
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
