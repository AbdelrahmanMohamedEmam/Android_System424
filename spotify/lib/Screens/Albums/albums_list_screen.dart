import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/album.dart';
import 'package:spotify/Models/track.dart';
import 'package:spotify/Providers/album_provider.dart';
import 'package:spotify/Providers/playable_track.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/widgets/song_item_in_playlist_list.dart';
import 'package:palette_generator/palette_generator.dart';

class AlbumsListScreen extends StatefulWidget {
  final AlbumCategory albumType;
  final String albumId;
  AlbumsListScreen({this.albumType, this.albumId});
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

  @override
  void didChangeDependencies() async {
    user = Provider.of<UserProvider>(context);
    await Provider.of<AlbumProvider>(context, listen: false)
        .fetchAlbumsTracksById(widget.albumId, user.token, widget.albumType)
        .then((_) {
      setState(() {
        _isLoading = false;
        List<Track> toAdd=Provider.of<AlbumProvider>(context, listen: false)
            .getPlayableTracks(widget.albumId, widget.albumType);
        Provider.of<PlayableTrackProvider>(context, listen: false).setTracksToBePlayed(toAdd);
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
    super.initState();
  }

  ///Generating a dark muted background color for the panel from the image of the song.
  Future<void> _generatePalette() async {
    if (albums != null) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!colorGenerated) _generatePalette();
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                'Album',
              ),
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
                      IconButton(
                        icon:
                            Icon(Icons.favorite_border, color: Colors.white54),
                        onPressed: null,
                        iconSize: 26,
                      ),
                      PopupMenuButton(
                        enabled: false,
                        itemBuilder: (_) => [],
                        icon: Icon(Icons.more_vert, color: Colors.white54),
                      )
                    ],
                    expandedHeight: 400,
                    pinned: true,
                    floating: false,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 50, bottom: 15),
                            height: 210,
                            width: double.infinity,
                            child: Image.network(
                              albums.image,
                            ),
                          ),
                          Container(
                            height: 40,
                            width: double.infinity,
                            child: Text(
                              albums.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            padding: EdgeInsets.only(bottom: 15),
                          ),
                          Container(
                            height: 22,
                            width: 160,
                            child: Container(
                              width: 100,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.grey[400]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.shuffle,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      'LISTEN IN SHUFFLE',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            padding: EdgeInsets.only(top: 7),
                            child: Text(
                              'Album by ' +
                                  "amr diab"/*albums.artists[0].name*/ +
                                  '.' +
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
                          width: 190.0,
                          child: FloatingActionButton(
                            onPressed: null,
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
                              child: SongItemPlaylistList(),
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
                        return SizedBox(height: 300);
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
    if (_scrollController.offset >= 140.0) {
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
