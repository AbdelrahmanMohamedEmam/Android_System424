import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/track_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/widgets/track_item_widget.dart';

class SearchScreenSeeAll extends StatefulWidget {
  final String searchedString;
  SearchScreenSeeAll({this.searchedString});
  @override
  _SearchScreenSeeAllState createState() => _SearchScreenSeeAllState();
}

class _SearchScreenSeeAllState extends State<SearchScreenSeeAll> {
  bool isLoading = false;
  UserProvider user;

  @override
  void didChangeDependencies() {
    user = Provider.of<UserProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    TrackProvider trackProvider =
        Provider.of<TrackProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("\""+widget.searchedString+"\"" " in Songs"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scroll) {
                if (!isLoading &&
                    scroll.metrics.pixels == scroll.metrics.maxScrollExtent&&trackProvider.nextTracks!=null) {
                  try {
                    setState(() {
                      isLoading = true;
                    });
                    trackProvider.fetchMoresearchedTracks(user.token).then((_) {
                      setState(() {
                        isLoading = false;
                      });
                    });
                  } catch (error) {
                    print(error.toString());
                  }
                }
              },
              child: Container(
                child: ListView.builder(
                  itemCount: trackProvider.getSearchedTracks.length,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                    value: trackProvider.getSearchedTracks[i],
                    child: TrackItemWidget(),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
