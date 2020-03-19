import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/SignUpAndLogIn/intro_screen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
//import 'package:spotify/Providers/album_provider.dart';
import '../../widgets/playlist_list_widget.dart';
//import '../../widgets/album_list_widget.dart';
//import 'package:spotify/Providers/artist_provider.dart';
<<<<<<< HEAD
//import './error_screen.dart';
=======
import '../../main.dart' as main;
>>>>>>> c59c7de952cf1a3743da01b3f60371dba1611103

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;
  bool isloading = true;
  @override
  void didChangeDependencies() {
    // try {
    Provider.of<PlaylistProvider>(context, listen: false)
        .fetchMadeForYouPlaylists();
<<<<<<< HEAD
    // Provider.of<PlaylistProvider>(context, listen: false)
    //     .fetchPopularPlaylists();
    // Provider.of<PlaylistProvider>(context, listen: false)
    //     .fetchWorkoutPlaylists();
    // Provider.of<AlbumProvider>(context, listen: false).fetchPopularAlbums();
    // } catch (error) {
    //   Navigator.of(context).pushNamed(ErrorScreen.routeName);
    // }
=======
    Provider.of<PlaylistProvider>(context, listen: false)
        .fetchPopularPlaylists();
    Provider.of<PlaylistProvider>(context, listen: false)
        .fetchWorkoutPlaylists();
    //Provider.of<AlbumProvider>(context, listen: false).fetchPopularAlbums();

>>>>>>> c59c7de952cf1a3743da01b3f60371dba1611103
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _auth=Provider.of<UserProvider>(context, listen: false);
    super.build(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 2),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 0,
            backgroundColor: Color.fromRGBO(18, 18, 18, 2),
            actions: <Widget>[
              FlatButton(
                onPressed: () {

                  _auth.logout();
                  Phoenix.rebirth(context);

                  //main.main;
                  //Navigator.of(context).pushReplacementNamed(IntroScreen.routeName);
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
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
                    // PlaylistList('Popular playlists'),
                    // PlaylistList('Workout'),
                    //AlbumList('Popular albums'),
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
