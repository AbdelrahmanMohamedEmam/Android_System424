import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import '../../widgets/item_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<PlaylistProvider>(context, listen: false).fetchPlaylists();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('The home screen is build');
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
              CategoryList(),
              CategoryList(),
              CategoryList(),
            ],
          ),
        ));
  }
}

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playlistspro = Provider.of<PlaylistProvider>(context);
    final playlists = playlistspro.playlists;
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              'Recently played',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
                itemCount: playlists.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) => ChangeNotifierProvider.value(
                      value: playlists[i],
                      child: ItemWidget(),
                    )),
          ),
        ],
      ),
    );
  }
}
