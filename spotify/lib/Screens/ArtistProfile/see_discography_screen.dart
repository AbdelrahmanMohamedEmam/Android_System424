import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../widgets/featured_playlists_artist_profile.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:provider/provider.dart';
import '../../Models/playlist.dart';
import 'package:spotify/Providers/artist_provider.dart';
import '../../Models/album.dart';
import '../../Providers/album_provider.dart';
import '../../widgets/album_widget_artist_profile.dart';
import '../../widgets/song_promo_card_artist_profile.dart';


class ReleasesScreen extends StatefulWidget {
  static const routeName = '/releases_screen';
  @override
  _ReleasesScreenState createState() => _ReleasesScreenState();
}

class _ReleasesScreenState extends State<ReleasesScreen> {
  void didChangeDependencies() async  {
    await Provider.of<PlaylistProvider>(context , listen: false)
        .fetchArtistProfilePlaylists();
    await Provider.of<ArtistProvider>(context ,  listen: false)
        .fetchMultipleArtists();
    //await Provider.of<ArtistProvider>(context , listen: false)
       // .fetchChoosedArtist();
    await Provider.of<AlbumProvider>(
        context, listen: false)
        .fetchPopularAlbums(
    );

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumProvider>(context);
    List<Album> albums;
    albums = albumProvider.getPopularAlbums;
    double heightAlbums = ((albums.length).toDouble())*100;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Releases' ,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        ),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.black,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              padding : EdgeInsets.only(top: 10 , bottom: 10),
              child: Text('Albums',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                ),
              ),
            ),

            Container(
              height: heightAlbums,
              width: double.infinity,
              child: ListView.builder(
                itemCount: albums.length,
                physics: const NeverScrollableScrollPhysics(),//to be replaced with fixed 4 items
                scrollDirection: Axis.vertical,
                itemBuilder: (context, i) => ChangeNotifierProvider.value(
                  value: albums[i],
                  child: LoadingAlbumsWidget(),
                ),
              ),
            ),
            Container(
              padding : EdgeInsets.only(top: 10 , bottom: 10),
              child: Text('Singles',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            SongPromoCard(),          //to be changed with list view
            SongPromoCard(),
            SongPromoCard(),
            SongPromoCard(),
            SongPromoCard(),
            SongPromoCard(),


          ],
        ),
      ),


    );
  }
}
