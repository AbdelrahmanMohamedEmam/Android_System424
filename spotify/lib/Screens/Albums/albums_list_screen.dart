import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/widgets/song_item_in_playlist_list.dart';

class AlbumsListScreen extends StatefulWidget {
  @override
  _AlbumsListScreenState createState() => _AlbumsListScreenState();
}

class _AlbumsListScreenState extends State<AlbumsListScreen> {
  ScrollController _scrollController;
  bool _isScrolled = false;
  bool _isLoading = true;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('The list of songs in album screen is built');

    String image =
        "https://dailymix-images.scdn.co/v1/img/ab67616d0000b273cfa4e906cda39d8f62fe81e3/1/en/default";
    String albumName = "Sahran";
    String albymByName = "Amr Diab";
    String releaseYear = "2020";
    String releaseDate = "May 6,2020";
    return /*_isLoading
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
        : */Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    title: Text(
                      albumName,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    centerTitle: true,
                    //backgroundColor: Color.fromRGBO(25, 20, 20, 7.0),
                    backgroundColor: Colors.black,
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
                              image,
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
                              albumName,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(), //////white box
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
                              'Album by  ' + albymByName + ' . ' + releaseYear,
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
                              //value: ,
                              child: SongItemPlaylistList(),
                            ),
                          ],
                        );
                      },
                      childCount: 6,
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
