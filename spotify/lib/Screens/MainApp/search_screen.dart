import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/track.dart';
import 'package:spotify/Providers/track_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/MainApp/search_screen_see_all.dart';
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
  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
  final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: deviceSize.height*0.088,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              left: deviceSize.width*0.0245,
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
            height:deviceSize.height*0.044,
          ),
          Container(
            width: deviceSize.width*0.95,
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
                    notFound=false;
                  });
                } catch (error) {
                  setState(() {
                    notFound = true;
                    trackProvider.emptySearchList();
                  });
                }
                tracks = trackProvider.getSearchedTracks;
              },
            ),
          ),
          if (search.text != "" && isSearched)
            SizedBox(
              height: deviceSize.height*0.0147,
            ),
          if (search.text != "" && isSearched&&!notFound)
            Container(
              height: deviceSize.height*0.513,
              child: ListView.builder(
                itemCount: tracks.length,
                itemBuilder: (context, i) => ChangeNotifierProvider.value(
                  value: tracks[i],
                  child: TrackItemWidget(),
                ),
              ),
            ),
          if (search.text == "")
            SizedBox(
              height: 50.0,
            ),
          if (search.text == "")
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
          if (notFound && search.text != "")
            SizedBox(
              height: deviceSize.height*0.074,
            ),
          if (notFound && search.text != "")
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "No results found for " + "\""+search.text+"\"",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          if (search.text != "" && isSearched&&!notFound)
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchScreenSeeAll(
                      searchedString: search.text,
                    ),
                  ),
                );
              },
              title: Text(
                "See all songs",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
