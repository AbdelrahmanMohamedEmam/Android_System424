import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/track.dart';
import 'package:spotify/Providers/album_provider.dart';
import 'package:spotify/Providers/track_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/widgets/track_item_widget.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search_screen';

  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TrackProvider trackProvider;
  UserProvider user;
  List<Track> tracks;
  bool isSearched = false;
  bool notFound = false;
  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false);
    trackProvider = Provider.of<TrackProvider>(context, listen: false);
    super.initState();
  }

  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 60.0,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              left: 10.0,
            ),
            child: Text(
              "Search",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 390,
            alignment: Alignment.center,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Search for songs',
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              controller: search,
              onChanged: (text) async {
                trackProvider.emptySearchList();
                setState(() {
                  isSearched = false;
                });
                try {
                  trackProvider.emptySearchList();
                  if (search.text != "") {
                    await trackProvider.fetchsearchedTracks(user.token, text);
                  }
                  setState(() {
                    isSearched = true;
                  });
                } catch (error) {
                  setState(() {
                    notFound = true;
                  });
                }
                tracks = trackProvider.getSearchedTracks;
              },
            ),
          ),
          if (isSearched && tracks != [])
            SizedBox(
              height: 10,
            ),
          if (isSearched && tracks != [])
            Container(
              height: 350,
              child: ListView.builder(
                itemCount: tracks.length,
                itemBuilder: (context, i) => ChangeNotifierProvider.value(
                  value: tracks[i],
                  child: TrackItemWidget(),
                ),
              ),
            ),
          if (!isSearched && search.text == "")
            SizedBox(
              height: 50.0,
            ),
          if (!isSearched && search.text == "")
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "Play what you love",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Search for songs",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          if (search.text != "" && notFound)
            SizedBox(
              height: 50.0,
            ),
          if (search.text != "" && notFound)
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "No results found for" + search.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
