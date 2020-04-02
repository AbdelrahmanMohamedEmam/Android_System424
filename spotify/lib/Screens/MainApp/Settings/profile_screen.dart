import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.transparent,
            title: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _isScrolled ? 1.0 : 0.0,
              curve: Curves.ease,
              child: Text(user.username),
            ),
            centerTitle: true,
            actions: <Widget>[Icon(Icons.more_vert)],
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(bottom: 8.0),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 20),
                    height: 180,
                    width: 150,
                    child: CircleAvatar(
                      maxRadius: 90,
                      child: Text(
                        user.username[0],
                        style: TextStyle(fontSize: 25),
                      ),
                      backgroundColor: Colors.purple,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      user.username,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 22.5,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(TabNavigatorRoutes.userEditProfileScreen);
                      },
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
                    SizedBox(
                      height: 500,
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
