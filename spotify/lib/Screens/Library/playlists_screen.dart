//import packages
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:spotify/Screens/Library/create_playlist_screen.dart';
import 'package:spotify/widgets/created_playlist_widget.dart';
//import widgets
import 'package:spotify/widgets/fav_playlist_widget.dart';
//import providers
import '../../Models/track.dart';
import '../../Providers/playable_track.dart';
import '../../Providers/playlist_provider.dart';
import 'package:provider/provider.dart';
//import models
import '../../Models/playlist.dart';
import '../../Providers/user_provider.dart';

class PlaylistsScreen extends StatefulWidget {
  @override
  _PlaylistsScreenState createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  UserProvider user;
  bool _isLoading = true;
  bool _isNotfound = false;

  @override
  void didChangeDependencies() async {
    user = Provider.of<UserProvider>(context, listen: false);
    try {
      await Provider.of<PlaylistProvider>(context, listen: false)
          .fetchLikedPlaylists(user.token);
      await Provider.of<PlaylistProvider>(context, listen: false)
          .fetchCreatedPlaylists(user.token)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } catch (error) {
      setState(() {
        _isNotfound = true;
        _isLoading = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = new ScreenScaler()..init(context);
    final playlistsProvider = Provider.of<PlaylistProvider>(context);
    List<Playlist> createdplaylists;
    List<Playlist> likedplaylists;
    likedplaylists = playlistsProvider.getlikedPlaylists;
    createdplaylists = playlistsProvider.getCreatedPlaylists;
    var height = likedplaylists.length * 70;
    return (_isLoading)
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          )
        : (_isNotfound)
            ? Container(
                height: 400,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Create your first playlist',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    Text(
                      'It\'s easy\',we\'ll help you.',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: true,
                            barrierColor: Colors.black87,
                            pageBuilder: (BuildContext context, _, __) {
                              return CreatePlaylistScreen();
                            }));
                      },
                      child: Text(
                        'CREATE PLAYLIST',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                    )
                  ],
                ),
              )
            // : Scaffold(
            //     backgroundColor: Colors.transparent,
            //     body: CustomScrollView(
            //       slivers: <Widget>[
            //         SliverList(
            //           delegate: SliverChildBuilderDelegate(
            //             (context, index) {
            //               return Column(
            //                 children: <Widget>[
            //                   if (likedplaylists.length != 0)
            //                     FavPlaylistWidget(PlaylistCategory.liked,
            //                         likedplaylists.id),
            //                   if (createdplaylists.length != 0)
            //                     CreatedPlaylistWidget(),
            //                 ],
            //               );
            //             },
            //             childCount: 1,
            //           ),
            //         )
            //       ],
            //     ),
            //   );
    : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              alignment: Alignment.centerLeft,
              child: FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: true,
                      barrierColor: Colors.black87,
                      pageBuilder: (BuildContext context, _, __) {
                        return CreatePlaylistScreen();
                      }));
                },
                icon: Icon(
                  Icons.add_box,
                  color: Colors.grey,
                  size: 60,
                ),
                label: Text(
                  'Create playlist',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            if (likedplaylists.length != 0)
              Container(
                height: height.toDouble(),
                //height: scaler.getHeight(40),
                child: ListView.builder(
                  itemCount: likedplaylists.length,
                  itemBuilder: (context, i) =>
                      ChangeNotifierProvider.value(
                    value: likedplaylists[i],
                    child: FavPlaylistWidget(
                        PlaylistCategory.liked, likedplaylists[i].id),
                  ),
                ),
              ),
            if (createdplaylists.length != 0)
              Container(
                // height: 350,
                height: scaler.getHeight(20),
                child: ListView.builder(
                  itemCount: createdplaylists.length,
                  itemBuilder: (context, i) =>
                      ChangeNotifierProvider.value(
                    value: createdplaylists[i],
                    child: CreatedPlaylistWidget(),
                  ),
                ),
              ),
          ],
        ),
      );
  }
}
