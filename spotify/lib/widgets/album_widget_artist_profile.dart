import 'package:flutter/material.dart';
import 'package:spotify/Providers/album_provider.dart';
import 'package:spotify/Screens/Albums/albums_list_screen.dart';
import '../Models/album.dart';
import 'package:provider/provider.dart';
//import '../Screens/MainApp/tab_navigator.dart';

class LoadingAlbumsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final album = Provider.of<Album>(context);
    return InkWell(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(deviceSize.height * 0.01),
            child: Image.network(
              album.image,
              height: deviceSize.height * 0.16,
              width: deviceSize.width * 0.16,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                album.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.shuffle,
                      color: Colors.grey,
                    ),
                    Text(
                      album.type,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AlbumsListScreen(
                  albumType: AlbumCategory.artist,
                  albumId: album.id,
                  artistName: "",
                )));
      },
    );
  }
}
