import 'package:flutter/material.dart';

//import providers
import 'package:provider/provider.dart';
//import models
import '../Models/track.dart';

class SongItemPlaylistList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final track= Provider.of<Track>(context);


    /*String image =
        "https://dailymix-images.scdn.co/v1/img/ab67616d0000b273cfa4e906cda39d8f62fe81e3/1/en/default";
    String songName = "J'me tire";*/
    String artistName = "Maitre Gims";
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: Image.network(track.imgUrl),
        title: Text(
          track.name,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          artistName,
          style: TextStyle(color: Colors.grey),
        ),
        trailing: Wrap(
          spacing: 3,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
              color: Colors.white,
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
