import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/playlist.dart';
import 'package:spotify/Providers/playable_track.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/Playlists/pop_up_menu_playlist_screen.dart';
import '../../widgets/song_item_in_playlist_list.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../Models/track.dart';

class PlaylistsListScreen extends StatefulWidget {
  final PlaylistCategory playlistType;
  final String playlistId;
  PlaylistsListScreen({this.playlistType, this.playlistId});
  @override
  _PlaylistsListScreenState createState() => _PlaylistsListScreenState();
}

class _PlaylistsListScreenState extends State<PlaylistsListScreen> {
  var playlistsProvider;
  UserProvider user;
  Playlist playlists;

  ScrollController _scrollController;
  bool _isScrolled = false;
  bool _isLoading = true;
  PaletteGenerator paletteGenerator;
  Color background = Colors.black87;
  bool colorGenerated = false;
  List<Playlist> madeForYou;

  @override
  void didChangeDependencies() async {
    user = Provider.of<UserProvider>(context);
    if (widget.playlistType == PlaylistCategory.recentlyPlayed) {
      await Provider.of<PlaylistProvider>(context, listen: false)
          .fetchRecentlyPlayedPlaylist(user.token, widget.playlistId);
    }

    await Provider.of<PlaylistProvider>(context, listen: false)
        .fetchPlaylistsTracksById(
            widget.playlistId, user.token, widget.playlistType)
        .then((_) {
      setState(() {
        List<Track> toAdd =
            Provider.of<PlaylistProvider>(context, listen: false)
                .getPlayableTracks(widget.playlistId, widget.playlistType);
        Provider.of<PlayableTrackProvider>(context, listen: false)
            .setTracksToBePlayed(toAdd);

        _isLoading = false;
        if (widget.playlistType == PlaylistCategory.mostRecentPlaylists) {
          playlists = Provider.of<PlaylistProvider>(context, listen: false)
              .getMostRecentPlaylistsId(widget.playlistId);
        } else if (widget.playlistType == PlaylistCategory.arabic) {
          playlists = Provider.of<PlaylistProvider>(context, listen: false)
              .getArabicPlaylistsId(widget.playlistId);
        } else if (widget.playlistType == PlaylistCategory.happy) {
          playlists = Provider.of<PlaylistProvider>(context, listen: false)
              .getHappyPlaylistsId(widget.playlistId);
        } else if (widget.playlistType == PlaylistCategory.jazz) {
          playlists = Provider.of<PlaylistProvider>(context, listen: false)
              .getJazzPlaylistsId(widget.playlistId);
        } else if (widget.playlistType == PlaylistCategory.pop) {
          playlists = Provider.of<PlaylistProvider>(context, listen: false)
              .getPopPlaylistsId(widget.playlistId);
        } else if (widget.playlistType == PlaylistCategory.popularPlaylists) {
          playlists = Provider.of<PlaylistProvider>(context, listen: false)
              .getPopularPlaylistsId(widget.playlistId);
        } else if (widget.playlistType == PlaylistCategory.artist) {
          playlists = Provider.of<PlaylistProvider>(context, listen: false)
              .getArtistPlaylistsbyId(widget.playlistId);
        } else if (widget.playlistType == PlaylistCategory.madeForYou) {
          playlists = Provider.of<PlaylistProvider>(context, listen: false)
              .getMadeForYoubyId(widget.playlistId);
        } else if (widget.playlistType == PlaylistCategory.liked) {
          playlists = Provider.of<PlaylistProvider>(context, listen: false)
              .getLikedPlaylistsId(widget.playlistId);
        } else if (widget.playlistType == PlaylistCategory.recentlyPlayed) {
          playlists = Provider.of<PlaylistProvider>(context, listen: false)
              .getRecentlyPlayedPlaylistById(widget.playlistId);
        }
      });
    });
    super.didChangeDependencies();
  }

  ///Initialization.
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    colorGenerated = false;
    String userToken = Provider.of<UserProvider>(context, listen: false).token;
    Provider.of<PlayableTrackProvider>(context, listen: false)
        .shuffledTrackList(userToken, widget.playlistId, 'playlist');

    super.initState();
  }

  ///Generating a dark muted background color for the panel from the image of the song.
  Future<void> _generatePalette() async {
    if (playlists != null) {
      PaletteGenerator _paletteGenerator =
          await PaletteGenerator.fromImageProvider(
              NetworkImage(playlists.images[0]),
              size: Size(110, 150),
              maximumColorCount: 20);
      if (_paletteGenerator.darkMutedColor != null) {
        background = _paletteGenerator.darkMutedColor.color;
        colorGenerated = true;
      }
      setState(
        () {
          paletteGenerator = _paletteGenerator;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final track = Provider.of<PlayableTrackProvider>(context, listen: false);
    if (!colorGenerated) _generatePalette();

    ///The device size provided by the [MediaQuery].
    final deviceSize = MediaQuery.of(context).size;
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    title: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: _isScrolled ? 1.0 : 0.0,
                      curve: Curves.ease,
                      child: Text(
                        playlists.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceSize.height * 0.0292), //20
                        textAlign: TextAlign.center,
                      ),
                    ),
                    centerTitle: true,
                    backgroundColor: background,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Provider.of<PlaylistProvider>(context, listen: true)
                                  .isPlaylistLiked(widget.playlistId)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (Provider.of<PlaylistProvider>(context,
                                  listen: false)
                              .isPlaylistLiked(widget.playlistId)) {
                            await Provider.of<PlaylistProvider>(context,
                                    listen: false)
                                .unlikePlaylist(user.token, widget.playlistId)
                                .then((_) {
                              setState(() {});
                            });
                          } else {
                            await Provider.of<PlaylistProvider>(context,
                                    listen: false)
                                .likePlaylist(user.token, widget.playlistId,
                                    widget.playlistType)
                                .then((_) {
                              setState(() {});
                            });
                          }
                        },
                        iconSize: deviceSize.width * 0.059, //26
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              barrierColor: Colors.black87,
                              pageBuilder: (BuildContext context, _, __) {
                                return PopUpMenuPlaylistScreen(
                                    playlists, widget.playlistType);
                              }));

                          //Navigator.pushNamed(context, SongSettingsScreen.routeName, arguments:widget.song);
                        },
                      ),
                    ],
                    expandedHeight: deviceSize.height * 0.52, //340
                    pinned: true,
                    floating: false,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                top: deviceSize.height * 0.07,
                                bottom: deviceSize.height *
                                    0.02), //top:50, bottom:15
                            height: deviceSize.height * 0.33,
                            width: double.infinity,
                            child: Image.network(
                              playlists.images[0],
                            ),
                          ),
                          Container(
                            height: deviceSize.height * 0.035, //27
                            width: double.infinity,
                            child: Text(
                              playlists.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: deviceSize.height * 0.029), //20
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                top: deviceSize.height * 0.0146),
                            height: deviceSize.height * 0.073,
                            child: Text(
                              'Made for ' +
                                  user.username +
                                  ' . ' +
                                  playlists.popularity.toString() +
                                  ' LIKES',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: deviceSize.height * 0.02),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    bottom: PreferredSize(
                      child: Transform.translate(
                        offset: Offset(0, 0),
                        child: Container(
                          width: deviceSize.width * 0.3406,
                          child: FloatingActionButton(
                            onPressed: () {
                              track.setCurrentSong(playlists.tracks[0],
                                  user.isUserPremium(), user.token);
                              Navigator.pop(context);
                            },
                            backgroundColor: Colors.green[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Text('PLAY'),
                          ),
                        ),
                      ),
                      preferredSize:
                          Size.fromHeight(deviceSize.height * 0.0878),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          children: <Widget>[
                            ChangeNotifierProvider.value(
                              value: playlists.tracks[index],
                              child: SongItemPlaylistList(playlists.id),
                            ),
                          ],
                        );
                      },
                      childCount: playlists.tracks.length,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return (playlists.tracks.length == 1)
                            ? SizedBox(height: 480)
                            : (playlists.tracks.length == 2)
                                ? SizedBox(height: 410)
                                : (playlists.tracks.length == 3)
                                    ? SizedBox(height: 350)
                                    : (playlists.tracks.length == 14)
                                        ? SizedBox(height: 80)
                                        : SizedBox(height: 480);
                      },
                      childCount: 1,
                    ),
                  ),
                  // Expanded(
                  //   child: Container(
                  //     child: MadeForYouPlaylists(),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
  }

  ///Functions to listen to the control of scrolling.
  void _listenToScrollChange() {
    if (_scrollController.offset >= 100.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }
}
