import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/MainApp/setting_screen.dart';
import 'package:spotify/Screens/MainApp/tab_navigator.dart';
import 'package:spotify/Screens/SignUpAndLogIn/intro_screen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:spotify/Providers/album_provider.dart';
import '../../widgets/playlist_list_widget.dart';
import '../../widgets/album_list_widget.dart';
import './tab_navigator.dart';
//import 'package:spotify/Providers/artist_provider.dart';
import '../../Widgets/trackPlayer.dart';
import '../../main.dart' as main;

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<PlaylistProvider>(context, listen: false)
        .fetchMadeForYouPlaylists();
    Provider.of<PlaylistProvider>(context, listen: false)
        .fetchPopularPlaylists();
    Provider.of<PlaylistProvider>(context, listen: false)
        .fetchWorkoutPlaylists();

    Provider.of<AlbumProvider>(context, listen: false).fetchPopularAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 2),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 0,
            backgroundColor: Color.fromRGBO(18, 18, 18, 2),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(TabNavigatorRoutes.settings);
                },
                icon: Icon(
                  Icons.settings,
                ),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: <Widget>[
                    PlaylistList('Made for you'),
                    PlaylistList('Popular playlists'),
                    PlaylistList('Workout'),
                    AlbumList('Popular albums'),
                    SizedBox(
                      height: 70,
                    )
                  ],
                );
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
