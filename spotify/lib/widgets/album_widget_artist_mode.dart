import 'package:flutter/material.dart';
import 'package:spotify/Providers/album_provider.dart';
import 'package:spotify/Screens/Albums/albums_list_screen.dart';
import 'package:spotify/Screens/ArtistMode/edit_song.dart';
import 'package:spotify/Screens/ArtistMode/edit_album_screen.dart';
import '../Models/album.dart';
import 'package:provider/provider.dart';
import '../Screens/MainApp/tab_navigator.dart';
//import '../Providers/album_provider.dart';
//import '../Screens/ArtistMode/add_song_screen.dart';


class ArtistModeAlbums extends StatefulWidget {
  @override
  _ArtistModeAlbumsState createState() => _ArtistModeAlbumsState();
}

class _ArtistModeAlbumsState extends State<ArtistModeAlbums> {
  /// variable to save the id of the album to edit or add song
  String id;

  void _goToStats(BuildContext ctx,) {
    Navigator.of(ctx).pushNamed(
      '/stats_screen',
    );
  }

  void _goToAddSong(BuildContext ctx, String id) {
    print(id);
    Navigator.of(ctx).pushNamed(TabNavigatorRoutes.addSongScreen, arguments: {
      "id": id,
    });
  }

  void _goToEditAlbum(BuildContext ctx, String id) {
    print(id);
    Navigator.of(ctx).pushNamed(TabNavigatorRoutes.editAlbumScreen, arguments: {
      "id": id,
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final album = Provider.of<Album>(context);
    id = album.id;
    var img = album.image;
    return Container(
      width: deviceSize.width,
      //margin: EdgeInsets.only(right: deviceSize.width * 0.1),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: FadeInImage(
                height: deviceSize.height * 0.13,
                width: deviceSize.width * 0.2,
                fit: BoxFit.fill,
                placeholder: AssetImage('assets/images/temp.jpg'),
                image: NetworkImage(album.image ),
              ),
              /*Image.network(
                album.image,
                height: deviceSize.height * 0.13,
                width: deviceSize.width * 0.2,
                fit: BoxFit.fill,
              ),*/

            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  album.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Icon(Icons.shuffle , color: Colors.grey, ),
                      Container(
                        width: deviceSize.width*0.55,
                        child: Text(
                          album.type,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //SizedBox(
             // width: deviceSize.width*0.4,
            //),
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.grey,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditAlbum(id :id )));
              }
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AlbumsListScreen(
                albumType: AlbumCategory.myAlbums,
                albumId: "5e90e8fbe1451e424477b131",
                artistName: "",
              )));
        },
      ),
    );
  }
}
