import 'package:flutter/material.dart';
import 'package:spotify/Models/artist.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/artist_provider.dart';

class suggesttedArtists extends StatelessWidget {
  String artistImage = "https://img.discogs.com/HSUEWRWhz_K3_6ycQh0p4LdH_D0=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4105059-1573135200-3103.jpeg.jpg";

  @override
  Widget build(BuildContext context) {
    final artist = Provider.of<Artist>(context);
    return InkWell(
      onTap: () {} ,
      child: Card (
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
                  artistImage,
                ),
                minRadius: 20,
                maxRadius: 50,
              ),
            ),

            Text(artist.name,
                style : TextStyle(
                  fontSize: 14,
                  color: Colors.white,

                )
            ),
          ],
        ),
      ),
    );
  }
}
