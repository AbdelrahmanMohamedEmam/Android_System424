import 'package:flutter/material.dart';

class suggesttedArtists extends StatelessWidget {
  String artistImage = "https://www.woolha.com/media/2019/06/buneary.jpg";
  String artistName = 'amrdiab';

  //FeaturedPlaylists(this.artistImage , this.artistName);
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

            Text(artistName ,
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
