//import packages
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:spotify/Screens/Library/create_playlist_screen.dart';
import 'package:spotify/widgets/created_playlist_widget.dart';
//import widgets
import 'package:spotify/widgets/fav_playlist_widget.dart';
import '../../widgets/liked_songs_widget.dart';
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
    final playableTrackProvider = Provider.of<PlayableTrackProvider>(context);
    List<Playlist> createdplaylists;
    List<Playlist> likedplaylists;
    List<Track> likedTracks;
    List<Playlist> allList;
    likedplaylists = playlistsProvider.getlikedPlaylists;
    createdplaylists = playlistsProvider.getCreatedPlaylists;
    likedTracks = playableTrackProvider.getLikedTracks;
    allList = likedplaylists + createdplaylists;
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
            : Column(
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
                  SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(),
                      child: Column(
                        children: <Widget>[
                          (likedTracks.length != 0) ? LikedSongWidget() : null,
                          Container(
                            height: 400,
                            child: ListView.builder(
                              itemCount: allList.length,
                              itemBuilder: (context, i) =>
                                  ChangeNotifierProvider.value(
                                value: allList[i],
                                child: (allList[i].category ==
                                        PlaylistCategory.liked)
                                    ? FavPlaylistWidget(PlaylistCategory.liked,
                                        likedplaylists[i].id)
                                    : CreatedPlaylistWidget(),
                              ),
                            ),
                          ),
                          SizedBox(height: 80)
                        ],
                      ),
                    ),
                  ),
                ],
              );
  }
}
