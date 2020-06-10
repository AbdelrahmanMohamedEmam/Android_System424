import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/album.dart';
import 'package:spotify/Models/chart_data.dart';
import 'package:spotify/Models/track.dart';
import 'package:spotify/Providers/album_provider.dart';
import 'package:spotify/Providers/charts_provider.dart';
import 'package:spotify/Providers/playable_track.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/Albums/pop_up_menu_album_screen.dart';
import 'package:spotify/Screens/ArtistMode/add_song_screen.dart';
import 'package:spotify/widgets/song_card_artist_mode.dart';
import 'package:spotify/widgets/song_item_in_album_list.dart';
import 'package:palette_generator/palette_generator.dart';

class AlbumsListScreen extends StatefulWidget {
  final AlbumCategory albumType;
  final String albumId;
  String artistName;
  AlbumsListScreen({this.albumType, this.albumId, this.artistName});
  @override
  _AlbumsListScreenState createState() => _AlbumsListScreenState();
}

class _AlbumsListScreenState extends State<AlbumsListScreen> {
  var albumsProvider;
  UserProvider user;
  Album albums;
  ScrollController _scrollController;
  bool _isScrolled = false;
  bool _isLoading = true;
  PaletteGenerator paletteGenerator;
  Color background = Colors.black87;
  bool colorGenerated = false;
  bool isArtist = false;


  @override
  void didChangeDependencies() async {
    user = Provider.of<UserProvider>(context);
    await Provider.of<AlbumProvider>(context, listen: false)
        .fetchRecentlyPlayedAlbum(user.token, widget.albumId);
    Provider.of<AlbumProvider>(context, listen: false)
        .fetchAlbumsTracksById(widget.albumId, user.token, widget.albumType)
        .then((_) {
      setState(() {
        List<Track> toAdd = Provider.of<AlbumProvider>(context, listen: false)
            .getPlayableTracks(widget.albumId, widget.albumType);
        Provider.of<PlayableTrackProvider>(context, listen: false)
            .setTracksToBePlayed(toAdd);
        _isLoading = false;
        if (widget.albumType == AlbumCategory.mostRecentAlbums) {
          albums = Provider.of<AlbumProvider>(context, listen: false)
              .getMostRecentAlbumsId(widget.albumId);
        } else if (widget.albumType == AlbumCategory.popularAlbums) {
          albums = Provider.of<AlbumProvider>(context, listen: false)
              .getPopularAlbumsId(widget.albumId);
        } else if (widget.albumType == AlbumCategory.artist) {
          albums = Provider.of<AlbumProvider>(context, listen: false)
              .getMyAlbumId(widget.albumId);
        } else if (widget.albumType == AlbumCategory.search) {
          albums = Provider.of<AlbumProvider>(context, listen: false)
              .getSearchedAlbumsId(widget.albumId);
        } else if (widget.albumType == AlbumCategory.myAlbums) {
          albums = Provider.of<AlbumProvider>(context, listen: false)
              .getMyAlbumId(widget.albumId);
        } else if (widget.albumType == AlbumCategory.liked) {
          albums = Provider.of<AlbumProvider>(context, listen: false)
              .getLikedAlbumsId(widget.albumId);
        } else if (widget.albumType == AlbumCategory.recentlyPlayed) {
          albums = Provider.of<AlbumProvider>(context, listen: false)
              .getRecentlyPlayedAlbumsById(widget.albumId);
        }
      });
    });
    super.didChangeDependencies();
  }

  ///Initialization.
  @override
  void initState() {
    String userToken = Provider.of<UserProvider>(context, listen: false).token;
    if (widget.albumType == AlbumCategory.myAlbums) {
      isArtist = true;
    } else {
      isArtist = false;
    }
    Provider.of<PlayableTrackProvider>(context, listen: false)
        .shuffledTrackList(userToken, widget.albumId, 'album');
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    colorGenerated = false;
    Provider.of<PlayableTrackProvider>(context, listen: false)
        .shuffledTrackList(userToken, widget.albumId, 'album');
    super.initState();
  }

  ///Generating a dark muted background color for the panel from the image of the song.
  Future<void> _generatePalette() async {
    if (albums != null && albums.image != null) {
      PaletteGenerator _paletteGenerator =
          await PaletteGenerator.fromImageProvider(NetworkImage(albums.image),
              size: Size(110, 150), maximumColorCount: 20);
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
    final deviceSize = MediaQuery.of(context).size;
    final track = Provider.of<PlayableTrackProvider>(context, listen: false);
    if (!colorGenerated) _generatePalette();
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                'Album',
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.library_add, color: Colors.white54),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddSongScreen(
                            id: widget.albumId,
                          ))),
                  iconSize: 26,
                )
              ],
              centerTitle: true,
            ),
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
                    title: Text(
                      albums.name,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    centerTitle: true,
                    backgroundColor: background,
                    actions: <Widget>[
                      isArtist
                          ? IconButton(
                              icon: Icon(Icons.library_add,
                                  color: Colors.white54),
                              onPressed: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddSongScreen(
                                            id: widget.albumId,
                                          ))),
                              iconSize: deviceSize.height * 0.03806,
                            )
                          : IconButton(
                              icon: Icon(
                                Provider.of<AlbumProvider>(context,
                                            listen: true)
                                        .isAlbumLiked(widget.albumId)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                if (Provider.of<AlbumProvider>(context,
                                        listen: false)
                                    .isAlbumLiked(widget.albumId)) {
                                  await Provider.of<AlbumProvider>(context,
                                          listen: false)
                                      .unlikeAlbum(user.token, widget.albumId)
                                      .then((_) {
                                    setState(() {});
                                  });
                                } else {
                                  await Provider.of<AlbumProvider>(context,
                                          listen: false)
                                      .likeAlbum(user.token, widget.albumId,
                                          widget.albumType)
                                      .then((_) {
                                    setState(() {});
                                  });
                                }
                              },
                              iconSize: deviceSize.height * 0.03806,
                            ),
                      isArtist
                          ? Container()
                          : IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    opaque: false,
                                    barrierColor: Colors.black87,
                                    pageBuilder: (BuildContext context, _, __) {
                                      return PopUpMenuAlbumScreen(
                                          albums, widget.albumType);
                                    }));
                              },
                            ),
                    ],
                    expandedHeight: deviceSize.height * 0.58565,
                    pinned: true,
                    floating: false,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                top: deviceSize.height * 0.073206,
                                bottom: deviceSize.height * 0.0219619),
                            height: deviceSize.height * 0.30746705,
                            width: double.infinity,
                            child: FadeInImage(
                              placeholder:
                                  AssetImage('assets/images/album.png'),
                              image: NetworkImage(albums.image),
                            ),
                          ),
                          Container(
                            height: deviceSize.height * 0.0585655,
                            width: double.infinity,
                            child: Text(
                              albums.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            padding: EdgeInsets.only(
                                bottom: deviceSize.height * 0.0219619),
                          ),
                          isArtist
                              ? Container()
                              : Container(
                                  height: deviceSize.height * 0.0322108,
                                  width: deviceSize.width * 0.3892944,
                                  child: Container(
                                    width: deviceSize.width * 0.243309,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.grey[400]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.shuffle,
                                            size: deviceSize.height * 0.0204978,
                                          ),
                                          SizedBox(
                                            width: deviceSize.width * 0.0170316,
                                          ),
                                          Text(
                                            'LISTEN IN SHUFFLE',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          Container(
                            width: double.infinity,
                            height: deviceSize.height * 0.073206,
                            padding: EdgeInsets.only(
                                top: deviceSize.height * 0.0102489),
                            child: Text(
                              widget.artistName == ""
                                  ? 'Album by ' +
                                      albums.artists[0].name +
                                      '. ' +
                                      albums.releaseDate.substring(0, 4)
                                  : 'Album by ' +
                                      widget.artistName +
                                      albums.releaseDate.substring(0, 4),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
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
                          width: deviceSize.width * 0.462287,
                          child: isArtist
                              ? Container()
                              : FloatingActionButton(
                                  onPressed: () {
                                    track.setCurrentSong(albums.tracks[0],
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
                      preferredSize: Size.fromHeight(60),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          children: <Widget>[
                            ChangeNotifierProvider.value(
                              value: albums.tracks[index],
                              child: isArtist
                                  ? SongItemArtistMode(albumId: widget.albumId)
                                  : SongItemAlbumList(albums.image),
                            ),
                          ],
                        );
                      },
                      childCount: albums.tracks.length,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return (albums.tracks.length == 1)
                            ? SizedBox(height: deviceSize.height * 0.7027818)
                            : (albums.tracks.length == 2)
                                ? SizedBox(
                                    height: deviceSize.height * 0.6002928)
                                : (albums.tracks.length == 3)
                                    ? SizedBox(
                                        height: deviceSize.height * 0.512445)
                                    : (albums.tracks.length == 14)
                                        ? SizedBox(
                                            height:
                                                deviceSize.height * 0.117130)
                                        : (albums.tracks.length == 10)
                                            ? SizedBox(
                                                height: deviceSize.height *
                                                    0.11713030)
                                            : SizedBox(
                                                height: deviceSize.height *
                                                    0.7021818);
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  ///Functions to listen to the control of scrolling.
  void _listenToScrollChange() {
    if (_scrollController.offset >= 100) {
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
