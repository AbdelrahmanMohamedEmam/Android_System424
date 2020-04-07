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
    String releaseDate = "1981-11-5";
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
        : */
        Scaffold(
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
              backgroundColor: Colors.black,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border,color: Colors.white54),
                  onPressed: null,
                  iconSize: 26,
                ),
                PopupMenuButton(
                  enabled: false,
                  itemBuilder: (_) =>
                   [],
                  icon: Icon(Icons.more_vert,color: Colors.white54),
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
                        
                      ),
                    ),
                    Container(
                      height: 40,
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
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                    Container(
                      height: 22,
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
                      padding: EdgeInsets.only(top:7),
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
                        'Album by  ' +
                            albymByName +
                            ' . ' +
                            releaseDate.substring(0, 4),
                        style: TextStyle(color: Colors.grey, fontSize: 14),
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
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       return Column(
            //         children: <Widget>[
            //           ChangeNotifierProvider.value(
            //             //value: ,
            //             child: SongItemPlaylistList(),
            //           ),
            //         ],
            //       );
            //     },
            //     childCount: 6,
            //   ),
            // ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       return SizedBox(height: 300);
            //     },
            //     childCount: 1,
            //   ),
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
