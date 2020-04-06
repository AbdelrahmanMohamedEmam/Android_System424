import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/play_history.dart';
import 'package:spotify/Providers/play_history_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import '../tab_navigator.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    final playHistory =
        Provider.of<PlayHistoryProvider>(context, listen: false);
    List<PlayHistory> recentlyPlayedartists =
        playHistory.getRecentlyPlayedArtists;
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: _isScrolled ? Colors.black : Colors.transparent,
            title: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _isScrolled ? 1.0 : 0.0,
              curve: Curves.ease,
              child: Text(user.username),
            ),
            centerTitle: true,
            actions: <Widget>[
              Icon(
                Icons.more_vert,
                color: Colors.grey,
              )
            ],
            expandedHeight: deviceSize.height * 0.440,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  EdgeInsets.only(bottom: deviceSize.height * 0.011714),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: deviceSize.height * 0.0440,
                      bottom: deviceSize.height * 0.02929,
                    ),
                    height: deviceSize.height * 0.264,
                    width: deviceSize.width * 0.365,
                    child: CircleAvatar(
                      maxRadius: deviceSize.width * 0.219,
                      child: Text(
                        user.username[0],
                        style: TextStyle(
                          fontSize: deviceSize.height * 0.0367,
                        ),
                      ),
                      backgroundColor: Colors.purple,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      user.username,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: deviceSize.height * 0.0367,
                      ),
                    ),
                  ),
                  Container(
                    width: deviceSize.width * 0.3407,
                    height: deviceSize.height * 0.03295,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            TabNavigatorRoutes.userEditProfileScreen);
                      },
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), //
                          side: BorderSide(color: Colors.white)),
                      child: Text(
                        'EDIT PROFILE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              user.userStats.playlistsNumber != 0
                                  ? Navigator.of(context).pushNamed(
                                      TabNavigatorRoutes.userPlaylistsScreen)
                                  : null;
                            },
                            child: Container(
                              height: 50,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    user.userStats.playlistsNumber.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'PLAYLISTS',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              user.userStats.followersNumber != 0
                                  ? Navigator.of(context).pushNamed(
                                      TabNavigatorRoutes.userFollowersScreen)
                                  : null;
                            },
                            child: Container(
                              height: 50,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    user.userStats.followersNumber.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'FOLLOWERS',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              user.userStats.followingNumber != 0
                                  ? Navigator.of(context).pushNamed(
                                      TabNavigatorRoutes.userFollowingScreen)
                                  : null;
                            },
                            child: Container(
                              height: 50,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    user.userStats.followingNumber.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'FOLLOWING',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Recently played artists',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    if (recentlyPlayedartists.length >= 1)
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                recentlyPlayedartists[0].context.image),
                          ),
                          title: Text(
                            recentlyPlayedartists[0].context.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            'followers',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    if (recentlyPlayedartists.length >= 2)
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                recentlyPlayedartists[1].context.image),
                          ),
                          title: Text(
                            recentlyPlayedartists[1].context.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            'followers',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    if (recentlyPlayedartists.length >= 3)
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                recentlyPlayedartists[2].context.image),
                          ),
                          title: Text(
                            recentlyPlayedartists[2].context.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            'followers',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    if (recentlyPlayedartists.length > 2)
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              TabNavigatorRoutes.recentlyPlayedArtistsScreen);
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            'See all',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 300,
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 48.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }
}
