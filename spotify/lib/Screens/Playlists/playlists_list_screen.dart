import 'package:flutter/material.dart';
import '../../widgets/song_item_in_playlist_list.dart';

class PlaylistsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('The list of songs in playlist screen is build');
    String image =
        "https://dailymix-images.scdn.co/v1/img/ab67616d0000b273cfa4e906cda39d8f62fe81e3/1/en/default";
    String playlistName = "Daily Mix 1";
    String madeForName = "Made for Farah Amr";
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
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
            expandedHeight: 270,
            
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(

              background: Container(
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
                padding: EdgeInsets.all(70),
                child: Image.network(
                  image,
                  fit: BoxFit.fitHeight,
                  height: 180,
                  width: 90,
                ),

              ),
              /*Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(madeForName),
                    ],
                  )*/

              title: Text(
                playlistName,
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              
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
                        /* gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(25, 20, 20, 7.0),
                            Color(0xFF191414),
                          ],
                          begin: Alignment.topLeft,
                          stops: [1.0,0.001],
                          end: FractionalOffset(0.8, 1.0),
                        ),*/
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
