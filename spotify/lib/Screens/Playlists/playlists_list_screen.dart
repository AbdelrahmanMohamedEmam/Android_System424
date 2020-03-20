/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/playlist.dart';

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
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                playlistName,
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          pinned: true,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
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
              width: double.infinity,
              padding: EdgeInsets.all(70),
              child: Image.network(
                image,
                fit: BoxFit.fitHeight,
                height: 200,
                width: 100,
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
              child: Align(
                alignment: Alignment(0.0, 0.0),
                child: Text(
                  madeForName,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                color: Colors.blue,
                height: 500,
              ),
              Divider(),
              Container(
                color: Colors.black12,
                height: 500,
              ),
              Divider(),
              Container(
                color: Colors.lightBlue,
                height: 500,
              ),
              Divider(),
            ],
          ),
        )
      ],
    ));
  }
}
*/