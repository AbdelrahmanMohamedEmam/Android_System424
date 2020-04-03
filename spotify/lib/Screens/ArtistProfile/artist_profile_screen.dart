import 'package:spotify/widgets/artist_info_widget.dart';
import '../../widgets/album_widget_artist_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../widgets/featured_playlists_artist_profile.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/suggested_artists_artist_profile.dart';
import '../../Models/playlist.dart';
import 'package:spotify/Models/artist.dart';
import 'package:spotify/Providers/artist_provider.dart';
import '../../Models/album.dart';
import '../../Providers/album_provider.dart';

class ArtistProfileScreen extends StatefulWidget {
  @override
  _ArtistProfileScreenState createState() => _ArtistProfileScreenState();
}

class _ArtistProfileScreenState extends State<ArtistProfileScreen> {


  bool _isInit = true;


  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<PlaylistProvider>(
          context, listen: false)
          .fetchArtistProfilePlaylists(
      );
      await Provider.of<ArtistProvider>(
          context, listen: false)
          .fetchMultipleArtists(
      );
      await Provider.of<AlbumProvider>(
          context, listen: false)
          .fetchPopularAlbums(
      );
      //await Provider.of<ArtistProvider>(
      //  context, listen: false)
      //.fetchChoosedArtist(
      //);
    }
    _isInit = false;
  }

  String artistName = 'amr diab 32';
  String artistNamePass;
  String artistId;
  String artistImageUrl;
  int artistPopularity;
  String artistBio;

  String artistImage =
      "https://img.discogs.com/HSUEWRWhz_K3_6ycQh0p4LdH_D0=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4105059-1573135200-3103.jpeg.jpg";

  void _goToDiscography(BuildContext ctx ,
      //String id (to be added)
      )
  {
    Navigator.of(ctx).pushNamed('/releases_screen' ,
      //arguments: id ,   (to be added)
    );
  }
  void _goToSongPromo(BuildContext ctx ,
      //String id (to be added)
      ) {
    Navigator.of(
        ctx).pushNamed(
      '/promo_screen',);
  }

  void _goToAbout(
      BuildContext ctx1,
      //arguments: id , name ,  (to be added)
      ) {
    Navigator.of(ctx1).pushNamed('/about_screen', arguments: {
      "id": artistId,
      "name": artistNamePass,
      "image": artistImageUrl,
      "popularity": artistPopularity.toString(),
      "bio": artistBio,
    });
  }

  @override
  Widget build(BuildContext context) {
    //initialization();

    final artistProvider = Provider.of<ArtistProvider>(context ,listen : false);
    List<Artist> artists ;
    artists = artistProvider.getMultipleArtists;
    //print(artists[0].externalUrls);
    //Artist artistInfo;
    //print(artists[1].name);
    //artistInfo = artistProvider.getChoosedArtist;
    // if(artistInfo.id!= null){
    // artistId = artistInfo.id;
    //}
    //artistImageUrl = artistInfo.images[0].url;
    //artistNamePass = artistInfo.name;
    //artistBio = artistInfo.bio;
    //artistPopularity = artistInfo.popularity;
    //print(artistPopularity);
    //print(artistPopularity);
    // print(artistImageUrl);
    //print('null is here');
    //print(artistNamePass);

    final playlistsProvider = Provider.of<PlaylistProvider>(context , listen : false);
    List<Playlist> playlists;
    playlists = playlistsProvider.getArtistProfilePlaylists;

    final albumProvider = Provider.of<AlbumProvider>(context);
    List<Album> albums;
    albums = albumProvider.getPopularAlbums;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          FlatButton(
            child: Text('FOLLOW'),
            textColor: Colors.grey,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            /*Container(
              height: 250,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: 1,
                  //scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                        value: artistInfo,
                        child: ArtistCard(),
                      )),
            ),*/
            //ArtistCard(),

            Container(
              height: 40,
              width: 50,
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  'SHUFFLE PLAY',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                //textColor: Colors.red,

                //color: Colors.grey,
                onPressed: () {},
              ),
            ),
            Container(
              height: 120,
              padding: EdgeInsets.only(left: 20, right: 20 , top: 30 , bottom: 30),
              color: Colors.black87,
              child: FlatButton(child :
              Text('Artist songs'),     //to be filled with artist's featured songs
                textColor: Colors.white,
                onPressed : () => _goToSongPromo(context),

              ),
            ),
            Text(
              'Popular releases',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Container(
              height: 200,
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
            ButtonTheme(
              minWidth: 5,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.black,
                textColor: Colors.white,
                child: Text(
                  'SEE DISCOGRAPHY',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => _goToDiscography(
                  context,
                  //id (to be added)
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Featuring' + ' ' + artistName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),

            //row of featured playlists
            Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: playlists.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                    value: playlists[i],
                    child: FeaturedPlaylists(),
                  )),
            ),

            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Fans also like ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: artists.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                    value: artists[i],
                    child: suggesttedArtists(),
                  )),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Artist Playlists',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: playlists.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                    value: playlists[i],
                    child: FeaturedPlaylists(),
                  )),
            ),

            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'About',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            InkWell(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Image.network(
                        artistImage,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 200,
                      bottom: 80,
                      left: 100,
                      right: 100,
                      child: Text(
                        artistName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    //
                  ],
                ),
                onTap: () {} //=> _goToAbout(context),
            ),
          ],
        ),
      ),
    );
  }
}