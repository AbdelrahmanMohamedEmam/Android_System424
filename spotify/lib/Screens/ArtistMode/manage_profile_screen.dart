
import 'package:flutter/material.dart';
import 'package:spotify/Screens/ArtistProfile/artist_profile_screen.dart';
import 'package:spotify/Screens/MainApp/tab_navigator.dart';
import '../../Models/artist.dart';
import '../../Providers/artist_provider.dart';
import 'package:provider/provider.dart';
import '../../Screens/MainApp/tab_navigator.dart';


class ManageProfileScreen extends StatefulWidget {
  static const   routeName='/manage_profile_screen';

  @override
  _ManageProfileScreenState createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {

 @override
  Widget build(BuildContext context) {
    //final artistProvider01 = Provider.of<ArtistProvider>(context , listen: false);
    //Artist artistInfo01;
    //artistInfo01 = artistProvider01.getChoosedArtist;
    //print(artistInfo01.name);
    return ArtistProfileScreen('5e8ca9999fc0e2db0516e4c0');
  }
}
