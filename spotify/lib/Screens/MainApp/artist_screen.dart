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
    bool user = Provider.of<UserProvider>(context, listen: false).isUserArtist();
    print(user.toString());
    print('The artist screen is build');
    if (!user){
      return ArtistProfileScreen("5e8cd05712fb247de895f052");
      //ArtistProfileScreen('5abSRg0xN1NV3gLbuvX24M'); //for mocking services
        //MyMusicScreen();
    }
    else
      {
        return MyMusicScreen();
      }


  }
}