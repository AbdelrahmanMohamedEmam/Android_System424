import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/playlist.dart';
import '../Screens/MainApp/tab_navigator.dart';

class PlaylistWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlist>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(TabNavigatorRoutes.playlistScreen);
      },
      child: Container(
        margin: EdgeInsets.only(left: 5),
        width: 140,
        child: Column(
          children: <Widget>[
            Container(
              height: 140,
              width: 140,
              child: FadeInImage(
                image: NetworkImage(playlist.images[0]),
                placeholder: AssetImage('assets/images/temp.jpg'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              height: 50,
              child: Text(
                playlist.description,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(117, 117, 117, 1),
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
