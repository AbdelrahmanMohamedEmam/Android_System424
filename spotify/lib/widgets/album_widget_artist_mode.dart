import 'package:flutter/material.dart';
import '../Models/album.dart';
import 'package:provider/provider.dart';

// This is the type used by the popup menu below.
enum choosed { delete, add_song , edit}

class ArtistModeAlbums extends StatefulWidget {
  //String albumImage = "https://i.scdn.co/image/c4818b1f9d0c7a793d421b51c63d82c8c768795c";
  //String albumName = 'Sahran';
  //String albumYear = '2020';
  //LoadingAlbumsWidget(this.albumImage , this.albumName , this.albumYear);
  @override
  _ArtistModeAlbumsState createState() => _ArtistModeAlbumsState();
}

class _ArtistModeAlbumsState extends State<ArtistModeAlbums> {
  void _goToStats(BuildContext ctx ,)
  {
    Navigator.of(ctx).pushNamed('/stats_screen' ,);
  }
  void _goToAddSong(BuildContext ctx ,)
  {
    Navigator.of(ctx).pushNamed('/add_song_screen' ,);
  }

  void choosedAction(choosed result)
  {
    if (result == choosed.delete)
      {
        _goToStats(context);
      }
    else if(result == choosed.edit)
      {
        _goToStats(context);
      }
    else
      _goToAddSong(context);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final album = Provider.of<Album>(context);
    return InkWell(
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
                SizedBox(
                  width: deviceSize.width*0.5,
                  height: 10,
                ),
              Container(
                color: Colors.black,
                child: PopupMenuButton<choosed>(
                  icon: Icon(Icons.more_vert,
                  color: Colors.white,
                  ),
                  onSelected: choosedAction,
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<choosed>>[
                        const PopupMenuItem<choosed>(
                        value: choosed.delete,
                        child: Text('delete album'),
                        ),
                        const PopupMenuItem<choosed>(
                        value: choosed.edit,
                        child: Text('edit album'),
                        ),
                        const PopupMenuItem<choosed>(
                        value: choosed.add_song,
                        child: Text('add a new song'),
                        ),
                ],
                ),
              ),
              ],
            ),
          ),
        ],
        ),

      ],
      ),
      onTap: () {},
    );



  }
}
