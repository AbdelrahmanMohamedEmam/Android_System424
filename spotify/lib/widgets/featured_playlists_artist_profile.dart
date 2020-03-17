import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../Models/playlist.dart';

class FeaturedPlaylists extends StatelessWidget {

  //FeaturedPlaylists(this.playListImage , this.playListName);
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlist>(context);
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
                playlist.images[0].url,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
            Text(playlist.name ,
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
