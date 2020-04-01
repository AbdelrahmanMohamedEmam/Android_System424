/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/playlist.dart';
//import 'package:flutter/src/rendering/box.dart';

class PlaylistsListScreen extends StatelessWidget {
  static const routeName = '/playlists_list_screen';

  void playPlaylistButton() {
    print('Play Button is pressed');
  }

  @override
  Widget build(BuildContext context) {
    print('The list of songs in playlist screen is build');
    //final loadedPlaylist = Provider.of<Playlist>(context);
    String image =
        "https://dailymix-images.scdn.co/v1/img/ab67616d0000b273cfa4e906cda39d8f62fe81e3/1/en/default";
    String playlistName = "Daily Mix 1";
    String madeForName = "Made for Farah Amr";

    return Scaffold(
      //backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers:<Widget>[
        SliverAppBar(
            floating: false,
            pinned: true,
            snap: false,
            title: Text(playlistName),
            
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              
              
              //collapseMode: CollapseMode.parallax,

              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 5.0, 3.5],
                    colors: <Color>[
                      Colors.blueGrey,
                      Colors.black45,
                      Colors.black38
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.grey,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  //Icons.favorite,
                ),
                onPressed: () {},
                iconSize: 36,
                color: Colors.white70,
              ),
              PopupMenuButton(
                itemBuilder: (_) => [
                  /*PopupMenuItem(child: Text('Like'),value:0),
                PopupMenuItem(child: Text('Share'),value:1),*/
                ],
                icon: Icon(Icons.more_horiz),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Image.network(
                  image,
                  fit: BoxFit.fitHeight,
                  height: 180,
                  width: 90,
                ),
              ),
              Text(
                madeForName,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                color: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 50.0),
                onPressed: playPlaylistButton,
                child: Text(
                  'PLAY',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
           /* ]*/

        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: <Widget>[],
            );
          },
        ))
      ],),
    );
  }
}
*/