import 'package:flutter/material.dart';
import '../ArtistProfile/artist_profile_screen.dart';
import '../../Screens/ArtistMode/manage_profile_screen.dart';
class ArtistScreen extends StatelessWidget {
  const ArtistScreen({Key key}) : super(key: key);
    static const   routeName='/artist_screen';
  @override
  Widget build(BuildContext context) {

    print('The artist screen is build');
<<<<<<< HEAD
    return //ArtistProfile_Screen();
    ManageProfileScreen();
=======
    return ArtistProfileScreen();
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
  }
}