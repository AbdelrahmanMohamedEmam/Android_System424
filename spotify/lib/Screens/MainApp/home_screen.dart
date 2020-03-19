import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import '../../widgets/playlist_list_widget.dart';
import 'package:spotify/Providers/artist_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<PlaylistProvider>(context, listen: false)
       .fetchMadeForYouPlaylists();
    Provider.of<PlaylistProvider>(context, listen: false)
        .fetchPopularPlaylists();


    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider .of<UserProvider>(context, listen: false).token);
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 2),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PlaylistList('Made for you'),
            PlaylistList('Popular playlists'),
          ],
        ),
      ),
    );
  }
}
