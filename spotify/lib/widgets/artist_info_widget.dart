import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/artist.dart';
import 'package:spotify/Providers/artist_provider.dart';


class ArtistCard extends StatelessWidget {

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
    );
  }
}
