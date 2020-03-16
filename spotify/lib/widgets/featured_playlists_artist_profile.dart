import 'package:flutter/material.dart';

class FeaturedPlaylists extends StatelessWidget {
  String playListImage = 'https://img.discogs.com/HSUEWRWhz_K3_6ycQh0p4LdH_D0=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4105059-1573135200-3103.jpeg.jpg';
  String playListName = 'most liked';

  //FeaturedPlaylists(this.playListImage , this.playListName);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {} ,
      child: Card (
        elevation: 20,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Container(

              padding: EdgeInsets.all(15),
              child: Image.network(
                playListImage,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
            Text(playListName ,
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
