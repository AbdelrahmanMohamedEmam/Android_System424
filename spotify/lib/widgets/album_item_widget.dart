import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/album_provider.dart';
import 'package:spotify/Screens/Albums/albums_list_screen.dart';
import '../Models/album.dart';
import '../Screens/MainApp/tab_navigator.dart';

class AlbumWidget extends StatelessWidget {
  final AlbumCategory albumCategory;
  AlbumWidget({this.albumCategory});
  @override
  Widget build(BuildContext context) {
    final album = Provider.of<Album>(context);
    print("enta d5lt album item");
    print(album.id);
    print(albumCategory);
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AlbumsListScreen(
              albumType: albumCategory,
              albumtId: album.id,
            ),
          ),
        );
      },
      child: Container(
        height: deviceSize.height * 0.317,
        width: deviceSize.width * 0.341,
        child: Column(
          children: <Widget>[
            Container(
              height: deviceSize.height * 0.205,
              width: deviceSize.width * 0.341,
              child: FadeInImage(
                image: NetworkImage(
                    album.image),
                placeholder: AssetImage('assets/images/album.png'),
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
                album.name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                maxLines: 1,
              ),
            ),
            Container(
              height: deviceSize.height * 0.0440,
              width: double.infinity,
              child: Text(
                album.type,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: deviceSize.width * 0.0292,
                  color: Color.fromRGBO(117, 117, 117, 1),
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
