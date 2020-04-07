//import packages
import 'package:flutter/material.dart';
//import providers
import 'package:provider/provider.dart';
//import models
import '../Models/playlist.dart';

class FavPlaylistWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlist>(context);

    return InkWell(
      onTap: null,
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
