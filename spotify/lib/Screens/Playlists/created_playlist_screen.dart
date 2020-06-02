import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/playlist.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/Library/add_song_to_playlist_screen.dart';
import 'package:spotify/Screens/Playlists/pop_up_menu_created_playlist_screen.dart';
import 'package:spotify/Screens/Playlists/pop_up_menu_playlist_screen.dart';

class CreatedPlaylistScreen extends StatefulWidget {
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
  String id;

  PaletteGenerator paletteGenerator;
  Color background = Colors.black87;
  bool colorGenerated = false;
  @override
  Future<void> didChangeDependencies() async {
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    user = Provider.of<UserProvider>(context);
    id = playlistProvider
        .getCreatedPlaylists[playlistProvider.getCreatedPlaylists.length - 1]
        .id;
    await Provider.of<PlaylistProvider>(context, listen: false)
        .fetchPlaylistsTracksById(id, user.token, PlaylistCategory.created)
        .then((_) {
      setState(() {
        _isLoading = false;
        playlists = Provider.of<PlaylistProvider>(context, listen: false)
            .getCreatedPlaylistsbyId(id);
      });
    });

    super.didChangeDependencies();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    colorGenerated = false;
    String userToken = Provider.of<UserProvider>(context, listen: false).token;
    super.initState();
  }

  ///Generating a dark muted background color for the panel from the image of the song.
  Future<void> _generatePalette() async {
    if (playlists.tracks != null) {
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
                    expandedHeight: deviceSize.height * 0.6, //340
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
                            child: FadeInImage(
                              image: NetworkImage(playlists.images[0]),
                              placeholder: AssetImage('assets/images/temp.jpg'),
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
                          Container(
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
                          ),
                        ],
                      ),
                    ),
                    bottom: PreferredSize(
                      child: Transform.translate(
                        offset: Offset(0, 0),
                        child: Container(
                          width: deviceSize.width * 0.5,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddSongToPlaylistScreen(id),
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
                ],
              ),
            ),
          );
  }

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
