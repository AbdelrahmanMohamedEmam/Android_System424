import 'package:flutter/material.dart';
import '../ArtistProfile/artist_profile_screen.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({Key key}) : super(key: key);
    static const   routeName='/artist_screen';
  @override
  Widget build(BuildContext context) {

    print('The artist screen is build');
    return ArtistProfile_Screen();
  }
}