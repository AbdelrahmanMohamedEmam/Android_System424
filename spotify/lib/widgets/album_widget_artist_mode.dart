import 'package:flutter/material.dart';
import '../Models/album.dart';
import 'package:provider/provider.dart';
import '../Screens/MainApp/tab_navigator.dart';
//import '../Providers/album_provider.dart';
import '../Screens/ArtistMode/add_song_screen.dart';

// This is the type used by the popup menu below.
enum choosed { delete, add_song , edit}

class ArtistModeAlbums extends StatefulWidget {
  @override
  _ArtistModeAlbumsState createState() => _ArtistModeAlbumsState();
}

class _ArtistModeAlbumsState extends State<ArtistModeAlbums> {
String id;
  void _goToStats(BuildContext ctx ,)
  {
    Navigator.of(ctx).pushNamed('/stats_screen' ,);
  }
  void _goToAddSong(BuildContext ctx ,String id)
  {
    Navigator.of(ctx).pushNamed(TabNavigatorRoutes.addSongScreen,
      arguments: {
      "id" : id,
      }
    );
  }

  /*void choosedAction(choosed result ,) //String id)
  {
    if (result == choosed.delete)
      {
        _goToStats(context);
      }
    else if(result == choosed.edit)
      {
        _goToStats(context);
      }
    else {
       _goToAddSong(context, id);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final album = Provider.of<Album>(context);
    id = album.id;
    print(id);
    return Container(
      width: deviceSize.width*0.7,
      margin: EdgeInsets.only(right:deviceSize.width*0.1 ),
      child: InkWell(
        child:
        Row(children: <Widget>[
          Container(
            padding : EdgeInsets.all(10),
            child: Image.network(
              album.images[0],
              height: deviceSize.height *0.13,
              width: deviceSize.width *0.2,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Text(album.name ,
              style: TextStyle(color : Colors.white , fontSize: 18 , ),
            ),

            Container(
              padding : EdgeInsets.only(top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Icon(Icons.shuffle , color: Colors.grey, ),
                  Text(album.type ,
                    style: TextStyle(color : Colors.grey , fontSize: 14 , ),
                  ),

                ],
              ),
            ),
          ],
          ),
        ],

        ),

        onTap: () => _goToAddSong(context , '5e8d0cc31e36896fbd0ad33b'),
      ),
    );
  }
}
