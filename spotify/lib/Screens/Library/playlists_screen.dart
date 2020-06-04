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
  PlaylistProvider playlistProvider;
  PlayableTrackProvider playableTrackProvider;
  bool _isLoading = true;
  bool _isNotfound = false;
  List<Playlist> allList;
  List<Playlist> playlists_tracks;
  List<Track> likedTracks;

  @override
  void didChangeDependencies() async {
    user = Provider.of<UserProvider>(context, listen: false);
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    playableTrackProvider = Provider.of<PlayableTrackProvider>(context);
    try {
      await playlistProvider.fetchLikedPlaylists(user.token);
      await playableTrackProvider.fetchUserLikedTracks(user.token, 50);

      // if (_isLoading != false) {
      await Provider.of<PlaylistProvider>(context, listen: false)
          .fetchCreatedPlaylists(user.token)
          .then((_) {
        playlists_tracks = playlistProvider.getCreatedPlaylists;
        allList = playlistProvider.getlikedPlaylists +
            playlistProvider.getCreatedPlaylists;
        likedTracks = playableTrackProvider.getLikedTracks;
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });

      // }
    } catch (error) {
      if (mounted) {
        setState(() {
          _isNotfound = true;
          _isLoading = false;
        });
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                            opaque: false,
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
                          (likedTracks.length != 0)
                              ? LikedSongWidget(likedTracks.length)
                              : SizedBox(height: 1),
                          Container(
                            height: (likedTracks.length != 0) ? 350 : 450,
                            child: ListView.builder(
                              itemCount: allList.length,
                              itemBuilder: (context, i) =>
                                  ChangeNotifierProvider.value(
                                value: allList[i],
                                child: (allList[i].category2 ==
                                        PlaylistCategory.liked)
                                    ? FavPlaylistWidget(
                                        PlaylistCategory.liked,
                                        playlistProvider
                                            .getlikedPlaylists[i].id)
                                    : CreatedPlaylistWidget(playlistProvider
                                        .getCreatedPlaylists[i -
                                            playlistProvider
                                                .getlikedPlaylists.length]
                                        .id),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
  }
}
