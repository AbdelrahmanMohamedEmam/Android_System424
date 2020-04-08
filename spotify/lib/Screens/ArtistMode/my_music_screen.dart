import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../../Models/album.dart';
import '../../Providers/album_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/album_widget_artist_mode.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../Screens/MainApp/tab_navigator.dart';
import '../../Providers/user_provider.dart';

class MyMusicScreen extends StatefulWidget {
  static const routeName = '//my_music_screen';

  @override
  _MyMusicScreenState createState() => _MyMusicScreenState();
}

class _MyMusicScreenState extends State<MyMusicScreen> {
  ScrollController _scrollController;
  bool _isScrolled = false;
  String token;
  String id;
  String name;
  String imageUrl;
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    super.initState();
  }

  File imageURI;
  bool _isLoading = false;
  bool _isInit = false;
  List<Album> albums;
  void didChangeDependencies() async {
    if (!_isInit) {
      setState(() {
        _isLoading = true;
      });
      final user = Provider.of<UserProvider>(context, listen: true).token;
      print(user);
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
  void _goToCreateAlbum(
    BuildContext ctx,
  ) {
    Navigator.of(ctx).pushNamed(
      TabNavigatorRoutes.addAlbumScreen,
    );
  }

  void _goToOverview(
    BuildContext ctx,
  ) {
    //Navigator.of(ctx).pushNamed(
      //TabNavigatorRoutes.artist,
    //);
  }

  void _goToStats(
    BuildContext ctx,
  ) {
    Navigator.of(ctx).pushNamed(
      '/stats_screen',
    );
  }

  void reloadAlbums()
  {
   // _isInit = false;
    setState(() {
      didChangeDependencies();
    });
  }
  void _listenToScrollChange() {
    if (_scrollController.offset >= 140.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('my music built');

    
    final deviceSize = MediaQuery.of(context).size;
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    albums = albumProvider.getMyAlbums;
    //reloadAlbums();
    //setUserInfo();
    return _isLoading
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
              title: Text('My Music Screen'),
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
                      accountName: Text('user.username'),
                      currentAccountPicture: CircleAvatar(
                          //backgroundImage: NetworkImage(user.userImage[0].url),
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
                      onTap: () => _goToStats(context),
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
                    height: deviceSize.height*0.4,
                    width: deviceSize.width*0.5,
                    child: ListView.builder(
                      itemCount: albums.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, i) => ChangeNotifierProvider.value(
                        value: albums[i],
                        child: ArtistModeAlbums(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
