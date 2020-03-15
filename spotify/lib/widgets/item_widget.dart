import 'package:flutter/material.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:provider/provider.dart';
import '../Models/playlist.dart';

class ItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlist>(context);
    print('the error is here');
    print(playlist.name);
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: 200,
            child: Image.network(
              playlist.images[0].url,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: 180,
            child: Text(
              playlist.name,
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
