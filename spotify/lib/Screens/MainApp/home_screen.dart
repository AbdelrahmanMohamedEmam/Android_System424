import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/categories_provider.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/MainApp/tab_navigator.dart';
import 'package:spotify/Providers/album_provider.dart';
import '../../widgets/playlist_list_widget.dart';
import '../../widgets/album_list_widget.dart';
import './tab_navigator.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  bool _isInit = false;
  UserProvider user;
  CategoriesProvider categoriesProvider;
  PlaylistProvider playlistProvider;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      setState(() {
        _isLoading = true;
      });
      categoriesProvider =
          Provider.of<CategoriesProvider>(context, listen: false);
      user = Provider.of<UserProvider>(context, listen: false);
      playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
      // Provider.of<PlayHistoryProvider>(context, listen: false)
      //     .fetchRecentlyPlayed(user.token);
      Provider.of<AlbumProvider>(context, listen: false)
          .fetchMostRecentAlbums(user.token);
      Provider.of<AlbumProvider>(context, listen: false)
          .fetchPopularAlbums(user.token);
      Provider.of<PlaylistProvider>(context, listen: false)
          .fetchMostRecentPlaylists(user.token);
      Provider.of<PlaylistProvider>(context, listen: false)
          .fetchPopularPlaylists(user.token);
      categoriesProvider.fetchHomeScreenCategories(user.token).then((_) {
        setState(() {
          if (categoriesProvider.isArabic) {
            playlistProvider.fetchArabicPlaylists(
                user.token, categoriesProvider.getArabicCategoryId);
          }
          if (categoriesProvider.isHappy) {
            playlistProvider.fetchHappyPlaylists(
                user.token, categoriesProvider.getHappyCategoryId);
          }
          if (categoriesProvider.isJazz) {
            playlistProvider.fetchJazzPlaylists(
                user.token, categoriesProvider.getJazzCategoryId);
          }
          if (categoriesProvider.isPop) {
            playlistProvider.fetchPopPlaylists(
                user.token, categoriesProvider.getPopCategoryId);
          }
          _isLoading = false;
        });
      });
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(40, 96, 65, 7.0),
                  Color(0xFF191414),
                ],
                begin: Alignment.topLeft,
                end: FractionalOffset(0.2, 0.2),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 0,
                    backgroundColor: Colors.transparent,
                    actions: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(TabNavigatorRoutes.settings);
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
                           // RecentlyPlayedList(),
                            PlaylistList(PlaylistCategory.mostRecentPlaylists),
                            PlaylistList(PlaylistCategory.popularPlaylists),
                            AlbumList('Popular albums'),
                            AlbumList('Most Recent Albums'),
                            if (categoriesProvider.isPop)
                              PlaylistList(PlaylistCategory.pop),
                            if (categoriesProvider.isJazz)
                              PlaylistList(PlaylistCategory.jazz),
                            if (categoriesProvider.isArabic)
                              PlaylistList(PlaylistCategory.arabic),
                            if (categoriesProvider.isHappy)
                              PlaylistList(PlaylistCategory.happy),
                            SizedBox(
                              height: deviceSize.height * 0.1713,
                            )
                          ],
                        );
                      },
                      childCount: 1,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
