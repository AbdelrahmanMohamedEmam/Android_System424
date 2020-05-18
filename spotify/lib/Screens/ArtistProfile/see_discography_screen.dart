import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/artist_provider.dart';
import '../../Models/album.dart';
import '../../Models/artist.dart';
import '../../Providers/album_provider.dart';
import '../../widgets/album_widget_artist_profile.dart';
//import '../../widgets/song_promo_card_artist_profile.dart';
import '../../Providers/artist_provider.dart';
//import '../../Providers/track_provider.dart';
//import '../../Models/track.dart';

class ReleasesScreen extends StatefulWidget {
  ///route name to get to the screen from navigator.
  static const routeName = '/releases_screen';
  @override
  _ReleasesScreenState createState() => _ReleasesScreenState();
}

class _ReleasesScreenState extends State<ReleasesScreen> {
  ///artist object to store the fetched data of the artist.
  Artist artistInfo;

  ///a method to initialize fetching data from providers.
  void didChangeDependencies() async {
    await Provider.of<AlbumProvider>(context, listen: false)
        .fetchPopularAlbums('');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ///getting device size due to responsiveness issues.
    final deviceSize = MediaQuery.of(context).size;

    ///artist provider object to get the ArtistInfo data from the artist object.
    final artistProvider = Provider.of<ArtistProvider>(context, listen: false);

    ///calling getter function.
    artistInfo = artistProvider.getChosenArtist;

    ///album provider object to get artist albums data from the album object.
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);

    ///list of albums to store albums data to be displayed.
    List<Album> albums;

    ///calling getter function.
    albums = albumProvider.getArtistAlbums;

    ///determining the height of the albums container based on the length of albums list.
    double heightAlbums = ((albums.length).toDouble()) * 150;

    ///tracks provider object to get artist top tracks data from the track object.
    //final tracksProvider = Provider.of<TrackProvider>(context, listen: false);

    ///list of albums to store tracks data to be displayed.
    //List<Track> tracks;

    ///calling getter function.
    //tracks = tracksProvider.getTopTracks;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Releases',
          style: TextStyle(
            fontSize: 18,
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
              padding: EdgeInsets.only(
                  top: deviceSize.height * 0.01,
                  bottom: deviceSize.height * 0.01),
              child: Text(
                'Albums',
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
                physics:
                    const NeverScrollableScrollPhysics(), //to be replaced with fixed 4 items
                scrollDirection: Axis.vertical,
                itemBuilder: (context, i) => ChangeNotifierProvider.value(
                  value: albums[i],
                  child: LoadingAlbumsWidget(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: deviceSize.height * 0.01,
                  bottom: deviceSize.height * 0.01),
              child: Text(
                'Singles',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            /*Container(
              height: deviceSize.height * 0.3,
              width: double.infinity,
              child: ListView.builder(
                itemCount: tracks.length,
                physics:
                NeverScrollableScrollPhysics(), //to be replaced with fixed 4 items
                scrollDirection: Axis.vertical,
                itemBuilder: (context, i) => ChangeNotifierProvider.value(
                  value: tracks[i] ,
                  child: SongPromoCard(),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
