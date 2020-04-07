import 'package:flutter/material.dart';
import 'package:spotify/Screens/ArtistMode/my_music_screen.dart';
import '../ArtistProfile/artist_profile_screen.dart';
import '../../Screens/ArtistMode/manage_profile_screen.dart';
import '../../Screens/ArtistMode/my_music_screen.dart';
import '../../Providers/user_provider.dart';
import 'package:provider/provider.dart';
class ArtistScreen extends StatelessWidget {
  const ArtistScreen({Key key}) : super(key: key);
    static const   routeName='/artist_screen';
  @override
  Widget build(BuildContext context) {
    //bool user = Provider.of<UserProvider>(context, listen: false).isUserArtist();
    print('The artist screen is build');
    if (//user
    true ){
      return ArtistProfileScreen("5e8ca9999fc0e2db0516e4c0");

    }
    /*else
      {
        return Scaffold(
          backgroundColor: Colors.black,
            appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Artist' , style: TextStyle(
            color: Colors.white,
            fontSize: 16
        ),
            ),
            ),
          body: Center(
            child: Text('You Are Not An Artist' ,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
            ),
          ),
        );
      }*/

    //ArtistProfileScreen();
    //ManageProfileScreen();
    //MyMusicScreen();
  }
}