//import packages
import 'package:flutter/material.dart';
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
  //bool _isNotfound = false;
  List<Playlist> allList;
  List<Playlist> playlistsTracks;
  List<Track> likedTracks;

  @override
  void didChangeDependencies() async {
    user = Provider.of<UserProvider>(context, listen: false);
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    playableTrackProvider = Provider.of<PlayableTrackProvider>(context);
    try {
      await playlistProvider.fetchLikedPlaylists(user.token);
      await playableTrackProvider.fetchUserLikedTracks(user.token, 50);
      await Provider.of<PlaylistProvider>(context, listen: false)
          .fetchCreatedPlaylists(user.token)
          .then((_) {
        playlistsTracks = playlistProvider.getCreatedPlaylists;
        allList = playlistProvider.getlikedPlaylists +
            playlistProvider.getCreatedPlaylists;
        likedTracks = playableTrackProvider.getLikedTracks;
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    } catch (error) {
      if (mounted) {
        setState(() {
          // _isNotfound = true;
          _isLoading = false;
        });
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
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
        : (playlistProvider.getCreatedPlaylists.isEmpty &&
                playlistProvider.getlikedPlaylists.isEmpty &&
                playableTrackProvider.getLikedTracks.isEmpty)
            ? Container(
                height: deviceSize.height * 0.58565,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Create your first playlist',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: deviceSize.height * 0.003,
                        bottom: deviceSize.height * 0.004392,
                        right: deviceSize.width * 0.0072992,
                        left: deviceSize.width * 0.0072992,
                      ),
                    ),
                    Text(
                      'It\'s easy\',we\'ll help you.',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: deviceSize.height * 0.014641,
                        bottom: deviceSize.height * 0.014641,
                        right: deviceSize.width * 0.024330,
                        left: deviceSize.width * 0.024330,
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(
                        vertical: deviceSize.height * 0.0117,
                        horizontal: deviceSize.width * 0.08,
                      ),
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
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                        textAlign: TextAlign.center,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(deviceSize.height * 0.0322),
                      ),
                    )
                  ],
                ),
              )
            : Column(
                children: <Widget>[
                  Container(
                    height: deviceSize.height * 0.09,
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            barrierColor: Colors.black87,
                            pageBuilder: (BuildContext context, _, __) {
                              return CreatePlaylistScreen();
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add_box,
                        color: Colors.grey,
                        size: deviceSize.height * 0.087847,
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
                              : SizedBox(height: deviceSize.height * 0.001146),
                          Container(
                            height: (likedTracks.length != 0)
                                ? deviceSize.height * 0.51244
                                : deviceSize.height * 0.58565,
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
