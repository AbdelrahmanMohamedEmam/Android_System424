import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/chart_data.dart';
import 'package:spotify/Providers/album_provider.dart';
import 'package:spotify/Providers/charts_provider.dart';
import 'package:spotify/Providers/playable_track.dart';
//import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/ArtistMode/edit_song.dart';
import 'package:spotify/Screens/ArtistMode/stats_screen.dart';
import '../Models/track.dart';

///It is used to provide the [PlaylistsListScreen] with the needed data about the track.
class SongItemArtistMode extends StatefulWidget {

  final albumId;
  //final trackId;

  SongItemArtistMode({this.albumId});
  @override
  _SongItemArtistModeState createState() => _SongItemArtistModeState();
}

class _SongItemArtistModeState extends State<SongItemArtistMode> {
  List<ChartData> fetched;
  List<ChartData> bar;
  List<ChartData> bar2;
  List<ChartData> line;
  List<ChartData> line2;
  var songId;
  var token;
  var songName;

  void _deleteSong(BuildContext ctx , String _userToken , String id , String trackId) async
  {
    final deviceSize = MediaQuery.of(context).size;
    bool deleted =
    await Provider.of<AlbumProvider>(context , listen: false)
        .deleteSong(_userToken , id , trackId);
    if(deleted)
      {
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Container(
                    height: deviceSize.height*0.1,
                    child: Text("Song deleted successfuly!"))));
        setState(() {
          Provider.of<AlbumProvider>(context, listen: false)
              .fetchAlbumsTracksById(widget.albumId, token, AlbumCategory.myAlbums);
        });
      }
    else
      {
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Container(
                    height: deviceSize.height*0.1,
                    child: Text("Something went wrong, please try again!"))));
      }

  }

  @override
  Widget build(BuildContext context) {
    final song = Provider.of<Track>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    songId =song.id;
    token = user.token;
    songName = song.name;
    final chartProvider =Provider.of<ChartsProvider>(context, listen: false);
    fetched = chartProvider.fetchedData;
    bar =chartProvider.fetchedBarData;
    bar2 =chartProvider.fetchedBarData2;
    line =chartProvider.fetchedLineData;
    line2 =chartProvider.fetchedLineData2;
    final track = Provider.of<PlayableTrackProvider>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    return Row(children: <Widget>[
      Container(
        width: deviceSize.width * 0.57,
        height: deviceSize.height * 0.1,
        child: InkWell(
          onTap: () {
            track.setCurrentSong(song,user.isUserPremium(),user.token);
            Navigator.pop(context);
          },
          child: ListTile(
            leading: Image.network(song.album.image),
            title: Text(
              song.name,
              style: TextStyle(color: Colors.grey),
            ),
            subtitle: Text(
              song.artists[0].name,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.insert_chart),
        color: Colors.grey,
        onPressed: () =>  Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StatsScreen(chart: fetched,bar: bar, bar2: bar2 , line: line , line2: line2 , name: songName,
            ))),
      ),
      IconButton(
        icon: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditSongScreen(
                albumId: widget.albumId,
                trackId: songId,
              )));
        },
      ),
      IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.white54,
        ),
        onPressed: () => _deleteSong(context , token , widget.albumId , songId),
      ),
    ]);
  }
}
