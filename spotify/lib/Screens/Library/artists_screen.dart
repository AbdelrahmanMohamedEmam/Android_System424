import 'dart:ui';
//import packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/artist.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/Library/follow_artist_screen.dart';
import 'package:spotify/widgets/followed_artist_widget.dart';

class ArtistsScreen extends StatefulWidget {
  @override
  _ArtistsScreenState createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  UserProvider user;
  bool _isLoading = true;
  bool _isNotfound = false;
  @override
  void didChangeDependencies() async {
    user = Provider.of<UserProvider>(context, listen: false);
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .fetchFollowedArtists(user.token)
          .then((_) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    } catch (error) {
      if (mounted) {
        setState(() {
          _isNotfound = true;
          _isLoading = false;
        });
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);
    List<Artist> followedArtists;
    followedArtists = userProvider.getFollowedArtists;
    return (_isLoading)
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          )
        : (_isNotfound)
            ? Scaffold(
                backgroundColor: Colors.black,
                body: Container(
                  child: FlatButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FollowArtistScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.control_point,
                      color: Colors.grey,
                      size: deviceSize.height*0.058565,
                    ),
                    label: Text(
                      'Choose artists',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    height: deviceSize.height*0.1024890,
                    margin: EdgeInsets.only(left: deviceSize.height*0.009),
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FollowArtistScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.control_point,
                        color: Colors.grey,
                        size: deviceSize.height*0.08784773,
                      ),
                      label: Text(
                        'Choose artists',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    height: deviceSize.height*0.51244509,
                    child: ListView.builder(
                      itemCount: followedArtists.length,
                      itemBuilder: (context, i) => ChangeNotifierProvider.value(
                        value: followedArtists[i],
                        child: FollowedArtistWidget(followedArtists[i]),
                      ),
                    ),
                  ),
                ],
              );
  }
}
