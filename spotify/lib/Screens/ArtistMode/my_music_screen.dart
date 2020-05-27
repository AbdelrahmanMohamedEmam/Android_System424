import 'package:flutter/material.dart';
import 'package:spotify/Models/chart_data.dart';
import 'package:spotify/Models/charts.dart';
import 'package:spotify/Screens/ArtistMode/stats_screen.dart';
import '../../Models/album.dart';
import '../../Providers/album_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/album_widget_artist_mode.dart';
import 'dart:io';
import '../../Screens/MainApp/tab_navigator.dart';
import '../../Providers/user_provider.dart';
import '../../Providers/charts_provider.dart';

class MyMusicScreen extends StatefulWidget {
  ///route name to get to the screen from navigator.
  static const routeName = '//my_music_screen';
  @override
  _MyMusicScreenState createState() => _MyMusicScreenState();
}

class _MyMusicScreenState extends State<MyMusicScreen> {
  //ScrollController _scrollController;
  //bool _isScrolled = false;
  ///String to store user token to be used in http request/
  String token;

  ///String to store id of the album to pass it to add song screen.
  String id;

  ///String to store name of the album to pass it to add song screen.
  String name;

  ///String to store image url of the album to pass it to add song screen.
  String imageUrl;
  File imageURI;

  ///String to control loading indicator.
  bool _isLoading = false;
  bool _isLoading2 = false;

  ///String to prevent re fetch data when re build screen.
  bool _isInit = false;

  ///List to store the fetched list of albums in this screen.
  List<Album> albums;

  ///variable to save user token
  var user;

  ///variable to save user name
  var username;

  ///variable to save user name
  var userImage;

  ///variable to check if the album is deleted or not
  bool deleted = false;

  List<ChartData> fetched;
  List<ChartData> bar;
  List<ChartData> bar2;
  List<ChartData> line;
  List<ChartData> line2;
  void initState() {
    //_scrollController = ScrollController();
    //_scrollController.addListener(_listenToScrollChange);
    super.initState();
  }

  ///Fetching data to the screen from providers.
  void didChangeDependencies() async {
    if (!_isInit) {
      setState(() {
        _isLoading = true;
      });
      user = Provider.of<UserProvider>(context, listen: false).token;
      username = Provider.of<UserProvider>(context, listen: false).username;
      userImage = Provider.of<UserProvider>(context, listen: false).userImage;
      await Provider.of<ChartsProvider>(
          context, listen: false)
         .fetchChartData();
      await Provider.of<ChartsProvider>(
          context, listen: false)
          .fetchBarChartData();
      await Provider.of<ChartsProvider>(
          context, listen: false)
          .fetchBarChartData2();
     await Provider.of<ChartsProvider>(
          context, listen: false)
         .fetchLineChartData();
      await Provider.of<ChartsProvider>(
          context, listen: false)
          .fetchLineChartData2();
      await Provider.of<AlbumProvider>(context, listen: false)
          .fetchMyAlbums(user)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  ///navigating to [CreateAlbum] screen.
  void _goToCreateAlbum(
    BuildContext ctx,
  ) {
    Navigator.of(ctx).pushNamed(
      TabNavigatorRoutes.addAlbumScreen,
    );
  }

  ///navigating to [overview] screen.
  void _goToOverview(
    BuildContext ctx,
  ) {
    Navigator.of(ctx).pushNamed(
      TabNavigatorRoutes.artist,
    );
  }

  ///navigating to [stats] screen.
  void _goToStats(BuildContext ctx)
  {
    Navigator.of(ctx).pushNamed(
  TabNavigatorRoutes.statsScreen);
  }

  /// a method used to reload albums list in case of adding new album.
  void reloadAlbums() {
    // _isInit = false;
    setState(() {
      didChangeDependencies();
    });
  }
  void _deleteAlbum(BuildContext ctx , String _userToken , String id ) async
  {
    deleted =
    await Provider.of<AlbumProvider>(context , listen: false)
        .deleteAlbum(_userToken , id);

  }

  /*void _listenToScrollChange() {
    if (_scrollController.offset >= 140.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    reloadAlbums();
    final deviceSize = MediaQuery.of(context).size;
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    albums = albumProvider.getMyAlbums;
    final chartProvider =Provider.of<ChartsProvider>(context, listen: false);
    fetched = chartProvider.fetchedData;
    bar =chartProvider.fetchedBarData;
    bar2 =chartProvider.fetchedBarData2;
    line =chartProvider.fetchedLineData;
    line2 =chartProvider.fetchedLineData2;
    //print(line[0].value);
    //print(albums[0].id);
    //setUserInfo();
    return (_isLoading)
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green[700],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text('My Music'),
              actions: <Widget>[
                Container(
                  padding: EdgeInsets.all(deviceSize.width * 0.03),
                  child: IconButton(
                    icon: Icon(
                      Icons.library_add,
                      color: Colors.white,
                      size: deviceSize.width * 0.08,
                    ),
                    onPressed: () => _goToCreateAlbum(context),
                  ),
                ),
              ],
            ),
            drawer: Drawer(
              child: Container(
                color: Colors.black,
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(username),
                      currentAccountPicture: CircleAvatar(
                        child: Container(
                          child: FadeInImage(
                            placeholder: AssetImage('assets/images/spotify_logo.jpg'),
                            image: NetworkImage(userImage[0]),
                          ),
                          ),
                          ),
                    ),

                    ListTile(
                      title: Text(
                        'Overview',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () => _goToOverview(context),
                    ),
                    ListTile(
                      title: Text(
                        'Stats',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StatsScreen(chart: fetched,bar: bar, bar2: bar2 , line: line , line2: line2
                          ))),
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
              color: Colors.black,
              height: double.infinity,
              width: double.infinity,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: deviceSize.height *0.8,
                    width: double.infinity ,
                    child: ListView.builder(
                      itemCount: albums.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, i) => ChangeNotifierProvider.value(
                        value: albums[i],
                        child: Dismissible(
                            child: ArtistModeAlbums(),
                            key: UniqueKey(),
                            background: Container(color: Colors.red),
                            onDismissed: (DismissDirection direction) {
                              _deleteAlbum(context, user, albums[i].id);
                                setState(() {
                                  albums.removeAt(i);
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Container(
                                                  height: deviceSize.height*0.1,
                                                  child: Text("album deleted successfuly!"))));
                                    });
                              //}
                            },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
