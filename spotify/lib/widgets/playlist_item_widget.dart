import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/playlist.dart';
//import '../Screens/Playlists/playlists_list_screen.dart';

class PlaylistWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlist>(context);
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Container(
        height: deviceSize.height * 0.317,
        width: deviceSize.width * 0.341,
        child: Column(
          children: <Widget>[
            Container(
              height: deviceSize.height * 0.205,
              width: deviceSize.width * 0.341,
              child: FadeInImage(
                image: NetworkImage(playlist.images[0]),
                placeholder: AssetImage('assets/images/temp.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: deviceSize.height * 0.0147,
              ),
              height: deviceSize.height * 0.0219,
              width: double.infinity,
              child: Text(
                playlist.name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: deviceSize.width * 0.0292,
                  color: Colors.white,
                ),
                maxLines: 1,
              ),
            ),
            Container(
              height: deviceSize.height * 0.0440,
              child: Text(
                playlist.description,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: deviceSize.width * 0.0292,
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
