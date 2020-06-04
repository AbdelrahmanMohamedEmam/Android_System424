import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/playlist.dart';
import 'package:spotify/Models/track.dart';
import 'package:spotify/Providers/playable_track.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/Library/add_song_to_playlist_screen.dart';
import 'package:spotify/Screens/Playlists/pop_up_menu_created_playlist_screen.dart';
import 'package:spotify/Screens/Playlists/pop_up_menu_playlist_screen.dart';
import 'package:spotify/widgets/song_item_in_playlist_list.dart';

class CreatedPlaylistScreen extends StatefulWidget {
  String id;
  CreatedPlaylistScreen(this.id);
  @override
  _CreatedPlaylistScreenState createState() => _CreatedPlaylistScreenState();
}

class _CreatedPlaylistScreenState extends State<CreatedPlaylistScreen> {
  ScrollController _scrollController;
  bool _isScrolled = false;
  bool _isLoading = true;
  UserProvider user;
  Playlist playlists;
  PlaylistProvider playlistProvider;
  //String id;
  bool firstTime = true;

  PaletteGenerator paletteGenerator;
  Color background = Colors.black87;
  bool colorGenerated = false;

  @override
  Future<void> didChangeDependencies() async {
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    user = Provider.of<UserProvider>(context, listen: false);
    try {
      Provider.of<PlaylistProvider>(context, listen: false)
          .fetchPlaylistsTracksById(
              widget.id, user.token, PlaylistCategory.created)
          .then((_) {
        setState(() {
          playlists = Provider.of<PlaylistProvider>(context, listen: false)
              .getCreatedPlaylistsbyId(widget.id);
          if (playlists.tracks != null && playlists.tracks.length != 0) {
            List<Track> toAdd =
                Provider.of<PlaylistProvider>(context, listen: false)
                    .getPlayableTracks(widget.id, PlaylistCategory.created);
            Provider.of<PlayableTrackProvider>(context, listen: false)
                .setTracksToBePlayed(toAdd);
            Provider.of<PlayableTrackProvider>(context, listen: false)
                .shuffledTrackList(user.token, widget.id, 'playlist');
          }
          _isLoading = false;
        });
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }

    super.didChangeDependencies();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    colorGenerated = false;

    super.initState();
  }

  ///Generating a dark muted background color for the panel from the image of the song.
  Future<void> _generatePalette() async {
    if (!playlists.tracks.isEmpty) {
      PaletteGenerator _paletteGenerator =
          await PaletteGenerator.fromImageProvider(
              NetworkImage(playlists.tracks[0].album.image),
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
    } else {
      background = Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    firstTime = false;
    //final song = Provider.of<Track>(context, listen: false);
    final track = Provider.of<PlayableTrackProvider>(context, listen: false);
    ScreenScaler scaler = new ScreenScaler()..init(context);
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
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              barrierColor: Colors.black87,
                              pageBuilder: (BuildContext context, _, __) {
                                return PopUpMenuCreatedPlaylistScreen(
                                    playlists);
                              }));
                        },
                      ),
                    ],
                    expandedHeight: deviceSize.height * 0.65, //340
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
                            child: (playlists.tracks != null &&
                                    playlists.tracks.length != 0)
                                ? FadeInImage(
                                    placeholder:
                                        AssetImage('assets/images/temp.jpg'),
                                    image: NetworkImage(
                                        playlists.tracks[0].album.image),
                                    fit: BoxFit.fitHeight,
                                  )
                                : FadeInImage(
                                    placeholder:
                                        AssetImage('assets/images/temp.jpg'),
                                    image: AssetImage('assets/images/temp.jpg'),
                                    fit: BoxFit.fitHeight,
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
                              'By ' + user.username,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: deviceSize.height * 0.02),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          (playlists.tracks == null ||
                                  playlists.tracks.length == 0)
                              ? Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: deviceSize.height * 0.0146),
                                  height: deviceSize.height * 0.073,
                                  child: Text(
                                    'Let\'s find some songs for your playlist',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: deviceSize.height * 0.02),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : SizedBox(height: 2),
                          (playlists.tracks != null &&
                                  playlists.tracks.length != 0)
                              ? Container(
                                  child: PreferredSize(
                                    child: Transform.translate(
                                      offset: Offset(0, 0),
                                      child: Container(
                                        width: deviceSize.width * 0.4,
                                        child: FloatingActionButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddSongToPlaylistScreen(
                                                        widget.id),
                                              ),
                                            );
                                          },
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: Text(
                                            'ADD SONGS',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    preferredSize: Size.fromHeight(
                                        deviceSize.height * 0.0878),
                                  ),
                                )
                              : SizedBox(height: 2),
                        ],
                      ),
                    ),

                    bottom: (playlists.tracks != null &&
                            playlists.tracks.length != 0)
                        ? PreferredSize(
                            child: Transform.translate(
                              offset: Offset(0, 0),
                              child: Container(
                                width: 190.0,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    track.setCurrentSong(playlists.tracks[0],
                                        user.isUserPremium(), user.token);
                                    Navigator.pop(context);
                                  },
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: Text(' SHUFFLE PLAY'),
                                ),
                              ),
                            ),
                            preferredSize: Size.fromHeight(70),
                          )
                        : PreferredSize(
                            child: Transform.translate(
                              offset: Offset(0, 0),
                              child: Container(
                                width: deviceSize.width * 0.4,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddSongToPlaylistScreen(widget.id),
                                      ),
                                    );
                                  },
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Text(
                                    'ADD SONGS',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            preferredSize:
                                Size.fromHeight(deviceSize.height * 0.0878),
                          ),
                  ),
                  if (playlists.tracks != null && playlists.tracks.length != 0)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        ((context, index) {
                          return Column(
                            children: <Widget>[
                              ChangeNotifierProvider.value(
                                value: playlists.tracks[index],
                                child: SongItemPlaylistList(),
                              ),
                            ],
                          );
                        }),
                        childCount: playlists.tracks.length,
                      ),
                    ),
                  //if (playlists.tracks != null && playlists.tracks.length != 0)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return (playlists.tracks.length == 1)
                            ? SizedBox(height: 480)
                            : (playlists.tracks.length == 2)
                                ? SizedBox(height: 420)
                                : (playlists.tracks.length == 3)
                                    ? SizedBox(height: 350)
                                    : (playlists.tracks.length == 14)
                                        ? SizedBox(height: 80)
                                        : SizedBox(height: 480);
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 200.0) {
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
