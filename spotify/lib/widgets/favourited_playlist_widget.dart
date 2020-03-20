import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/playlist.dart';

class FavouritedPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlist>(context);

    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: Image.network(playlist.images[0]),
        title: Text(
          playlist.name,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          playlist.category,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
