import 'package:flutter/material.dart';
import 'package:spotify/Screens/Library/albums_screen.dart';
import 'package:spotify/Screens/Library/playlists_screen.dart';
import 'package:spotify/Screens/Library/artists_screen.dart';

class LibraryScreen extends StatelessWidget {
  static const routeName = '/library_screen';

  const LibraryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      int initialindex = 0;
    print('The library screen is build');
    return DefaultTabController(
      length: 3,
      initialIndex: initialindex,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Music',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          bottom: TabBar(
              indicatorColor: Colors.lightGreen,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Playlists',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Artists',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Albums',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ]),
        ),
        body: TabBarView(children: <Widget>[
          Container(
            height: 300,
            child: PlaylistsScreen()),
          ArtistsScreen(),
          AlbumsScreen(),
        ]),
      ),
    );
  }
}
