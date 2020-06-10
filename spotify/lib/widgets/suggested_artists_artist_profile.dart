import 'package:flutter/material.dart';
import 'package:spotify/Models/artist.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/artist_provider.dart';
import 'package:spotify/Screens/ArtistProfile/artist_profile_screen.dart';

class suggesttedArtists extends StatelessWidget {
  String artistImage =
      "https://img.discogs.com/HSUEWRWhz_K3_6ycQh0p4LdH_D0=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4105059-1573135200-3103.jpeg.jpg";

  @override
  Widget build(BuildContext context) {
    final artist = Provider.of<Artist>(context);
    return InkWell(
      onTap:() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ArtistProfileScreen(
              id: artist.id,
            )));
      },
      child: Card(
        elevation: 20,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  artist.images[0],
                  //"https://i.scdn.co/image/c4818b1f9d0c7a793d421b51c63d82c8c768795c"
                ),
                minRadius: 20,
                maxRadius: 50,
              ),
            ),
            Text(artist.name,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
