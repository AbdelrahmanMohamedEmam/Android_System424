import 'package:flutter/material.dart';

class SongItemPlaylistList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String image =
        "https://dailymix-images.scdn.co/v1/img/ab67616d0000b273cfa4e906cda39d8f62fe81e3/1/en/default";
    String songName = "J'me tire";
    String artistName = "Maitre Gims";
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: Image.network(image),
        title: Text(
          songName,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          artistName,
          style: TextStyle(color: Colors.grey),
        ),
        trailing: Wrap(
          spacing: 7,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
              color: Colors.white,
            ),
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
