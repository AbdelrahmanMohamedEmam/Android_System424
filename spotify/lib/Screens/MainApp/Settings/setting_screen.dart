import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:spotify/Screens/MainApp/tab_navigator.dart';
import '../tab_navigator.dart';
import '../../../Providers/user_provider.dart';
import '../../../Providers/playlist_provider.dart';
import 'package:provider/provider.dart';
import '../../Providers/playable_track.dart';
import '../../Models/track.dart';
import '../../Models/artist.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(48, 44, 44, 1),
        centerTitle: true,
        title: Text(
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (!_auth.isUserPremium())
              Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    'Free Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            if (!_auth.isUserPremium())
              Container(
                height: 38,
                width: 160,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(TabNavigatorRoutes.premium2);
                  },
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    'GO PREMIUM',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(TabNavigatorRoutes.profileScreen);
              },
              leading: CircleAvatar(
                backgroundColor: Color.fromRGBO(27, 255, 138, 1),
                child: Text(
                  _auth.username[0],
                  style: TextStyle(
                    color: Color.fromRGBO(20, 20, 20, 1),
                  ),
                ),
              ),
              title: Text(
                _auth.username,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'View profile',
                style: TextStyle(color: Colors.grey),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              ),
            ),
            ListTile(
              // onTap: () {},
              title: Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'Choose which notifications to recieve.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                /*Provider.of<PlayableTrackProvider>(context, listen: false).setCurrentSong(
                    Track(
                        id: '2',
                        name: 'Gamda Bas',
                        album: 'Sahran',
                        artists: [
                          Artist(
                            name: 'Amr Diab',
                            bio: '',
                          )
                        ],
                        imgUrl:
                        'https://i1.sndcdn.com/artworks-000685259938-at3rot-t500x500.jpg',
                        href:
                        'https://nogomistars.com/Online_Foldern/Amr_Diab/Sahraan/Nogomi.com_Amr_Diab-01.Gamda_Bas.mp3',
                        trackNumber: 1));*/

                _auth.logout();
                Provider.of<PlaylistProvider>(context, listen: false)
                    .emptyLists();
                // while (Navigator.of(context).canPop()) Navigator.pop(context);
                Phoenix.rebirth(context);
              },
              title: Text(
                'Log out',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'You are logged in as ' + _auth.username,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(24, 20, 20, 1),
    );
  }
}
