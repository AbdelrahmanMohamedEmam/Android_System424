import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/track.dart';

class SongItemPlaylistList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final song = Provider.of<Track>(context, listen: false);

    String artistName = "Maitre Gims";
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: Image.network(song.imgUrl),
        title: Text(
          song.name,
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
