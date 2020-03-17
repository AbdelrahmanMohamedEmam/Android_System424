import '../../widgets/album_widget_artist_profile.dart';
//import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../widgets/featured_playlists_artist_profile.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/suggested_artists_artist_profile.dart';
import '../../Models/playlist.dart';

class ArtistProfile_Screen extends StatefulWidget {
  @override
  _ArtistProfile_ScreenState createState() => _ArtistProfile_ScreenState();
}

class _ArtistProfile_ScreenState extends State<ArtistProfile_Screen> {
  @override
  void didChangeDependencies() {
    Provider.of<PlaylistProvider>(context, listen: false)
        .fetchArtistProfilePlaylists();
    super.didChangeDependencies();
  }

  String artistName = 'Amr Diab';

  String artistImage = "https://img.discogs.com/HSUEWRWhz_K3_6ycQh0p4LdH_D0=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4105059-1573135200-3103.jpeg.jpg";

  @override
  Widget build(BuildContext context) {
    final playlistsProvider = Provider.of<PlaylistProvider>(context);
    List<Playlist> playlists;
      playlists = playlistsProvider.getArtistProfilePlaylists;
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

      body:
      Container(
        color: Colors.black,
        child: ListView(
          scrollDirection: Axis.vertical,
          children : <Widget> [
            Stack(
              children : <Widget> [
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
                  left: 70,
                  right: 100,
                  child: Text(artistName ,
                    textAlign: TextAlign.center,
                    style : TextStyle(color: Colors.green ,
                      fontWeight: FontWeight.bold ,
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              width:  50 ,
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child : Text('SHUFFLE PLAY',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                //textColor: Colors.red,

                //color: Colors.grey,
                onPressed : () {},
              ),
            ),
            Container(
              height: 120,
              padding: EdgeInsets.only(left: 20, right: 20 , top: 30 , bottom: 30),
              //color: Colors.black87,
              child: FlatButton(child :
              Text('Artist songs'),     //to be filled with artist's features songs
                textColor: Colors.white,

                onPressed : () {},

              ),
            ),
            Text('Popular releases' ,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            //new widget file for albums (4 albums )
            LoadingAlbumsWidget(),
            LoadingAlbumsWidget(),
            LoadingAlbumsWidget(),
            LoadingAlbumsWidget(),
            ButtonTheme(
              minWidth: 5,
              child: RaisedButton(
                shape : RoundedRectangleBorder(side: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.black,
                textColor: Colors.white,
                child: Text('SEE DISCOGRAPHY' ,
                  style: TextStyle(fontSize: 16 ,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed : () {},

              ),
            ),

            Container(
              padding : EdgeInsets.only(top: 30 , bottom: 10),
              child: Text('Featuring' + ' ' + artistName ,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
            ),

            //row of featured playlists
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
              padding : EdgeInsets.only(top: 30 , bottom: 10),
              child: Text('Fans also like ' ,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  suggesttedArtists(),
                  suggesttedArtists(),
                  suggesttedArtists(),
                  suggesttedArtists(),
                  suggesttedArtists(),
                  suggesttedArtists(),
                  suggesttedArtists(),

                ],


              ),

            ),
            Container(
              padding : EdgeInsets.only(top: 30 , bottom: 10),
              child: Text('Artist Playlists',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
            ),
            FeaturedPlaylists(),
            Container(
              padding : EdgeInsets.only(top: 30 , bottom: 10),
              child: Text('About',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
            ),
            InkWell(
              child: Stack(
                children : <Widget> [
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
                    child: Text(artistName ,
                      textAlign: TextAlign.center,
                      style : TextStyle(color: Colors.green ,
                        fontWeight: FontWeight.bold ,
                        fontSize: 50,
                      ),
                    ),
                  ),
                  //
                ],
              ),
              onTap: () {},
            ),







          ],
        ),

      ),



    );
  }
}






