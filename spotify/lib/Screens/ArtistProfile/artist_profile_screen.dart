import '../../Widgets/artist_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:provider/provider.dart';
import '../../Models/playlist.dart';
import 'package:spotify/Models/artist.dart';
import 'package:spotify/Providers/artist_provider.dart';
import '../../Models/album.dart';
import '../../Providers/album_provider.dart';
<<<<<<< HEAD
import 'package:http/http.dart' as http;
import 'dart:convert';
class ArtistProfile_Screen extends StatefulWidget {
=======
import '../MainApp/tab_navigator.dart';

class ArtistProfileScreen extends StatefulWidget {
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
  @override
  ArtistProfileScreenState createState() => ArtistProfileScreenState();
}

class ArtistProfileScreenState extends State<ArtistProfileScreen> {
  Artist artistInfo;
  List<Artist> artists = [];
  List<Playlist> playlists;
  List<Album> albums;

  @override
  void initState() {
    initialization();
    super.initState();
  }

<<<<<<< HEAD
  bool _isInit = true;
  Future <Artist> artistInfo;


=======
  Future<void> initialization() async {
    final artistProv = Provider.of<ArtistProvider>(context, listen: false);
    await artistProv.fetchMultipleArtists();
    await artistProv.fetchChoosedArtist();
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223

    final playlistProv = Provider.of<PlaylistProvider>(context, listen: false);
    await playlistProv.fetchArtistProfilePlaylists();

<<<<<<< HEAD
  @override
  void Initial() async {
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
      await Provider.of<ArtistProvider>(
       context, listen: false)
      .fetchChoosedArtist();
    }
    _isInit = false;
    //super.didChangeDependencies();
=======
    final albumProv = Provider.of<AlbumProvider>(context, listen: false);
    await albumProv.fetchPopularAlbums();

    setState(() {
      artists = artistProv.getMultipleArtists;
      artistInfo = artistProv.getChoosedArtist;
      playlists = playlistProv.getArtistProfilePlaylists;
      albums = albumProv.getPopularAlbums;
    });
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
  }

  String artistName = 'amr diab 32';
  String artistNamePass;
  String artistId;
  String artistImageUrl;
  int artistPopularity;
  String artistBio;
  int follow;

  //String artistImage =
     // "https://img.discogs.com/HSUEWRWhz_K3_6ycQh0p4LdH_D0=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4105059-1573135200-3103.jpeg.jpg";

  Future<Artist> ArtistGetter() async
  {
    final artistProvider = Provider.of<ArtistProvider>(context , listen:  false);

    artistInfo = artistProvider.getChoosedArtist;
    //print(artistInfo);
    return artistInfo;

    }





<<<<<<< HEAD
  void _goToDiscography(BuildContext ctx ,
      //String id (to be added)
      )
  {
    Navigator.of(ctx).pushNamed('/releases_screen' ,
      //arguments: id ,   (to be added)
    );
  }
  void _goToSongPromo(BuildContext ctx )
  {
    Navigator.of(
        ctx).pushNamed(
      '/promo_screen');
=======
  void _goToDiscography(
    BuildContext ctx,
    //String id (to be added)
  ) {
    Navigator.of(ctx).pushNamed(
      TabNavigatorRoutes.discographyScreen,
      //arguments: id ,   (to be added)
    );
  }

  void _goToSongPromo(
    BuildContext ctx,
    //String id (to be added)
  ) {
    Navigator.of(ctx).pushNamed(
      '/promo_screen',
    );
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
  }

  /*void _goToAbout(BuildContext ctx1, String artistId) {
    Navigator.of(ctx1).pushNamed('/about_screen' //arguments: {
      //"id": artistId,
      //"name": artistNamePass,
      //"image": artistImageUrl,
      //"popularity": artistPopularity.toString(),
      //"bio": artistBio,
   // }
    );
  }*/
  var testLen = 1;


  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    Initial();
print('built');
    final artistProvider = Provider.of<ArtistProvider>(context , listen:  false);
    List<Artist> artists ;
    artists = artistProvider.getMultipleArtists;
    //Artist artistInfo;
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

    final playlistsProvider = Provider.of<PlaylistProvider>(context, listen: false);
    List<Playlist> playlists;
    playlists = playlistsProvider.getArtistProfilePlaylists;

    final albumProvider = Provider.of<AlbumProvider>(context);
    List<Album> albums;
    albums = albumProvider.getPopularAlbums;
=======
    if (artistInfo == null) {
      setState(() {});
    }
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223

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
<<<<<<< HEAD
            Container(
              height: 250,
              width: double.infinity,
              child: FutureBuilder(
                future :ArtistGetter(),
                builder: (BuildContext context , AsyncSnapshot snapshot){
                  if(snapshot.data == null)
                    {
                      return Container(
                        child:Center(
                          child: Image.asset('assets/images/temp.jpg',
                          fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  else {
                    //artistNamePass = snapshot.data.name;
                    //artistId = snapshot.data.id;
                    //artistImageUrl = snapshot.data.images[0].url;
                     //artistPopularity = snapshot.data.popularity;
                     //artistBio = snapshot.data.bio;
                     //print(artistNamePass);
                     print(snapshot.data.followers.total);
                    return ListView.builder(
                      itemCount: testLen,
                      itemBuilder: (context, i) {
                        return
                          Stack(
                            children : <Widget> [
                              Container(
                                height: 300,
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                child: Image.network(
                                    snapshot.data.images[0].url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Positioned(
                                top: 120,
                                bottom: 80,
                                left: 70,
                                right: 100,
                                child: Text(snapshot.data.name,
                                  textAlign: TextAlign.center,
                                  style : TextStyle(color: Colors.white ,
                                    fontWeight: FontWeight.bold ,
                                    fontSize: 50,
                                  ),
                                ),
                              ),
                            ],
                          );
                      }
                    );
                  }
                },
              ),

            ),
            //ArtistCard(),

=======
            ArtistCard(artistInfo: artistInfo),
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
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
<<<<<<< HEAD
              padding: EdgeInsets.only(left: 20, right: 20 , top: 30 , bottom: 30),
              color: Colors.black87,
              child: FlatButton(child :
              Text('Artist songs'),     //to be filled with artist's featured songs
                textColor: Colors.white,
                onPressed : () => _goToSongPromo(context),

=======
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
              color: Colors.black87,
              child: FlatButton(
                child: Text(
                    'Artist songs'), //to be filled with artist's featured songs
                textColor: Colors.white,
                onPressed: () => _goToSongPromo(context),
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
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
            /* Container(
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
            ),*/
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
<<<<<<< HEAD
            Container(
=======
            /* Container(
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: playlists.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                    value: playlists[i],
                    child: FeaturedPlaylists(),
                  )),
            ),*/

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
<<<<<<< HEAD
           Container(
=======
            /* Container(
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: artists.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
<<<<<<< HEAD
                    value: artists[i],
                    child: suggesttedArtists(),
                  )),
            ),
=======
                        value: artists[i],
                        child: suggesttedArtists(),
                      )),
            ),*/
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
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
            /* Container(
              height: 250,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: playlists.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                    value: playlists[i],
                    child: FeaturedPlaylists(),
                  )),
            ),*/

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
<<<<<<< HEAD

            /*Container(
              height: 250,
              width: double.infinity,
              child: FutureBuilder(
                future :ArtistGetter(),
                builder: (BuildContext context , AsyncSnapshot snapshot){
                  if(snapshot.data == null)
                  {
                    return Container(
                      child:Center(
                        child: Image.asset('assets/images/temp.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                  else {
                    artistNamePass = snapshot.data.name;
                    artistId = snapshot.data.id;
                    artistImageUrl = snapshot.data.images[0].url;
                    artistPopularity = snapshot.data.popularity;
                    artistBio = snapshot.data.bio;
                    print(artistNamePass);
                    return ListView.builder(
                        itemCount: testLen,
                        itemBuilder: (context, i) {
                          return
                            Stack(
                              children : <Widget> [
                                Container(
                                  height: 300,
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  child: Image.network(
                                    snapshot.data.images[0].url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 120,
                                  bottom: 80,
                                  left: 70,
                                  right: 100,
                                  child: Text(snapshot.data.name,
                                    textAlign: TextAlign.center,
                                    style : TextStyle(color: Colors.white ,
                                      fontWeight: FontWeight.bold ,
                                      fontSize: 50,
                                    ),
                                  ),
                                ),
                              ],
                            );
                        }
                    );
                  }
                },
              ),

            ),*/
            /*InkWell(
=======
            InkWell(
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Image.network(
<<<<<<< HEAD
                        artistImageUrl,
=======
                        artistImage,
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
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
<<<<<<< HEAD
                        artistNamePass,
=======
                        artistName,
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
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
<<<<<<< HEAD
                //onTap: () => _goToAbout(context , artistId),
            ),*/
=======
                onTap: () {} //=> _goToAbout(context),
                ),
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
          ],
        ),
      ),
    );
  }
}