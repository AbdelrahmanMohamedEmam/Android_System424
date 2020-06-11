import 'package:flutter/material.dart';
import 'package:spotify/Models/chart_data.dart';
import 'package:spotify/Providers/album_provider.dart';
import 'package:spotify/Providers/charts_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/Albums/albums_list_screen.dart';
//import 'package:spotify/Screens/ArtistMode/edit_song.dart';
import 'package:spotify/Screens/ArtistMode/edit_album_screen.dart';
import 'package:spotify/Screens/ArtistMode/stats_screen.dart';
import '../Models/album.dart';
import 'package:provider/provider.dart';
//import '../Screens/MainApp/tab_navigator.dart';
//import '../Providers/album_provider.dart';
//import '../Screens/ArtistMode/add_song_screen.dart';


class ArtistModeAlbums extends StatefulWidget {
  @override
  _ArtistModeAlbumsState createState() => _ArtistModeAlbumsState();
}

class _ArtistModeAlbumsState extends State<ArtistModeAlbums> {
  /// variable to save the id of the album to edit or add song
  String id;
  bool deleted;
  List<ChartData> fetched;
  List<ChartData> bar;
  List<ChartData> bar2;
  List<ChartData> line;
  List<ChartData> line2;
  void _deleteAlbum(BuildContext ctx , String _userToken , String id ) async
  {
    final deviceSize = MediaQuery.of(context).size;
    deleted =
    await Provider.of<AlbumProvider>(context , listen: false)
        .deleteAlbum(_userToken , id);
    if(deleted)
    {
      Scaffold.of(context).showSnackBar(
          SnackBar(
              content: Container(
                  height: deviceSize.height*0.1,
                  child: Text("album deleted successfuly!"))));
      print('popped');
    }
    else
    {
      Scaffold.of(context).showSnackBar(
          SnackBar(
              content: Container(
                  height: deviceSize.height*0.1,
                  child: Text("something went wrong ,please try again!"))));
    }

  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final album = Provider.of<Album>(context);
    id = album.id;
    var img = album.image;
    final chartProvider =Provider.of<ChartsProvider>(context, listen: false);
    fetched = chartProvider.fetchedData;
    bar =chartProvider.fetchedBarData;
    bar2 =chartProvider.fetchedBarData2;
    line =chartProvider.fetchedLineData;
    line2 =chartProvider.fetchedLineData2;
    String _user = Provider.of<UserProvider>(context, listen: false).token;
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
                        width: deviceSize.width*0.35,
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
              icon: Icon(Icons.insert_chart),
              color: Colors.grey,
              onPressed: () =>  Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StatsScreen(chart: fetched,bar: bar, bar2: bar2 , line: line , line2: line2 , name: album.name,
                ))),
            ),
            IconButton(
                icon: Icon(Icons.delete),
                color: Colors.grey,
                onPressed: () => _deleteAlbum(context , _user , id),
            ),
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
                albumId: id,
                artistName: "",
              )));
        },
      ),
    );
  }
}


