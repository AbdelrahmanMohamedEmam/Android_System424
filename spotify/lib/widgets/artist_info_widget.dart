import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/artist.dart';
import 'package:spotify/Providers/artist_provider.dart';

class ArtistCard extends StatelessWidget {

<<<<<<< HEAD
  //String artistImage = "https://img.discogs.com/HSUEWRWhz_K3_6ycQh0p4LdH_D0=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4105059-1573135200-3103.jpeg.jpg";
  //String artistName = 'amr diab1';
  @override
  Widget build(BuildContext context) {
    final artistsInformation = Provider.of<Artist>(context);
    return
      Stack(
      children : <Widget> [
      Container(
        height: 300,
        width: double.infinity,
      padding: EdgeInsets.all(15),
      child: FadeInImage(
        placeholder: AssetImage('assets/images/temp.jpg'),
        image: NetworkImage(
          artistsInformation.images[0].url,
        ),
      ),
    ),
    Positioned(
    top: 120,
    bottom: 80,
    left: 70,
    right: 100,
    child: Text(artistsInformation.name,
    textAlign: TextAlign.center,
    style : TextStyle(color: Colors.white ,
    fontWeight: FontWeight.bold ,
    fontSize: 50,
    ),
    ),
    ),
    ],
=======
  final Artist artistInfo;



  final String artistImage =
      "https://img.discogs.com/HSUEWRWhz_K3_6ycQh0p4LdH_D0=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4105059-1573135200-3103.jpeg.jpg";
  final String artistName = 'amr diab1';

  ArtistCard({this.artistInfo});
  @override
  Widget build(BuildContext context) {
    return Stack(
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
          top: 120,
          bottom: 80,
          left: 70,
          right: 100,
          child: Text(
            artistInfo.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
        ),
      ],
>>>>>>> 1ca6f43230b8dcac3d7303c6eba68a1f22ad0223
    );
  }
}
