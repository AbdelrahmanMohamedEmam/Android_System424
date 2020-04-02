import 'package:flutter/material.dart';
import '../../widgets/song_item_in_playlist_list.dart';

class PlaylistsListScreen extends StatefulWidget {
  @override
  _PlaylistsListScreenState createState() => _PlaylistsListScreenState();
}

class _PlaylistsListScreenState extends State<PlaylistsListScreen> {
  ScrollController _scrollController;
  bool _isScrolled = false;

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
    return Scaffold(
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
                  playlistName,
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
                  icon: Icon(Icons.more_horiz),
                )
              ],
              expandedHeight: 340,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 50, bottom: 30),
                      height: 180,
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
                        image,
                        fit: BoxFit.fitHeight,
                        height: 180,
                        width: 90,
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
                      child: Text(
                        playlistName,
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
                        madeForName,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top:6.0),
                      width: 110,
                      height: 50,
                      child: FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Text('PLAY'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        child: SongItemPlaylistList(),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(25, 20, 20, 7.0),
                        ),
                      )
                    ],
                  );
                },
                childCount: 1,
              ),
            )
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
