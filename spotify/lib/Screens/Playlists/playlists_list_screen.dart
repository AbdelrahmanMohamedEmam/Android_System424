import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/playlist.dart';
import 'package:spotify/Models/track.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import '../../widgets/song_item_in_playlist_list.dart';

class PlaylistsListScreen extends StatefulWidget {
  final String playlistId;
  PlaylistsListScreen(this.playlistId);
  @override
  _PlaylistsListScreenState createState() => _PlaylistsListScreenState();
}

class _PlaylistsListScreenState extends State<PlaylistsListScreen> {
  var playlistsProvider;
  var user;
  Playlist playlistsProvider2;
  ScrollController _scrollController;
  bool _isScrolled = false;
  bool _isLoading = true;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      playlistsProvider = Provider.of<PlaylistProvider>(context, listen: false)
          .fetchMadeForYouPlaylistTracksById(widget.playlistId)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      playlistsProvider2 = Provider.of<PlaylistProvider>(context)
          .getMadeForYouPlaylistbyId(widget.playlistId);
      user = Provider.of<UserProvider>(context);
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('The list of songs in playlist screen is built');
    String image =
        "https://dailymix-images.scdn.co/v1/img/ab67616d0000b273cfa4e906cda39d8f62fe81e3/1/en/default";
    String playlistName = "Daily Mix 1";
    String madeForName = "Made for Farah Amr";
    String noOfLikes = "1 LIKE";
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
                        playlistsProvider2.name,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    centerTitle: true,
                    backgroundColor: Color.fromRGBO(25, 20, 20, 7.0),
                    //backgroundColor: Colors.black,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {},
                        iconSize: 26,
                      ),
                      PopupMenuButton(
                        itemBuilder: (_) => [
                          /*PopupMenuItem(child: Text('Like'),value:0),
                  PopupMenuItem(child: Text('Share'),value:1),*/
                        ],
                        icon: Icon(Icons.more_vert),
                      )
                    ],
                    expandedHeight: 340,
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
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(100, 150, 180, 5.0),
                                  Color(0xFF191414),
                                ],
                                begin: Alignment.topLeft,
                                end: FractionalOffset(1.0, 0.1),
                              ),
                            ),
                            width: double.infinity,
                            child: Image.network(
                              playlistsProvider2.images[0],
                              //colorBlendMode: BlendMode.colorBurn,
                              //fit: BoxFit.fitHeight,
                            ),
                          ),
                          Container(
                            height: 27,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(100, 150, 180, 5.0),
                                  Color(0xFF191414),
                                ],
                                begin: Alignment.topLeft,
                                end: FractionalOffset(1.0, 0.1),
                              ),
                            ),
                            child: Text(
                              playlistsProvider2.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(100, 150, 180, 5.0),
                                  Color(0xFF191414),
                                ],
                                begin: Alignment.topLeft,
                                end: FractionalOffset(1.0, 0.1),
                              ),
                            ),
                            padding: EdgeInsets.only(top: 10),
                            height: 50,
                            child: Text(
                              'Made for' + user.username,
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
                          width: 140.0,
                          child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Text('PLAY'),
                          ),
                        ),
                      ),
                      preferredSize: Size.fromHeight(60),
                    ),
                  ),
                  /*SliverPadding(
              padding: EdgeInsets.only(bottom: 10.0),
            ),*/
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          children: <Widget>[
                            ChangeNotifierProvider.value(
                              value: playlistsProvider2.tracks2[index],
                              child: SongItemPlaylistList(),
                            ),
                          ],
                        );
                      },
                      childCount: playlistsProvider2.tracks2.length,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return SizedBox(height: 600);
                      },
                      childCount: 1,
                    ),
                  ),
                  // SizedBox(
                  //   height: 200,
                  // ),
                ],
              ),
            ),
          );
  }

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
