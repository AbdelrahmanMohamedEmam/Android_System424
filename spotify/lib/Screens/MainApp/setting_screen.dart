import 'package:flutter/material.dart';
import 'package:spotify/Screens/MainApp/tab_navigator.dart';
import './premium_screen.dart';
import './tabs_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isPremium = false;

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                child: isPremium
                    ? Text(
                        'PremiumAccount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )
                    : Text(
                        'Free Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
              ),
            ),
            Container(
              height: 38,
              width: 160,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(TabNavigatorRoutes.premium2);
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) {
                  //       return PremiumScreen();
                  //     },
                  //   ),
                  // );
                  // _auth.logout();
                  // Provider.of<PlaylistProvider>(context, listen: false)
                  //     .emptyLists();
                  // while(Navigator.of(context).canPop())
                  //   Navigator.pop(context);
                  // Phoenix.rebirth(context);
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
              leading: CircleAvatar(
                backgroundColor: Color.fromRGBO(27, 255, 138, 1),
                child: Text(
                  'A',
                  style: TextStyle(
                    color: Color.fromRGBO(20, 20, 20, 1),
                  ),
                ),
              ),
              title: Text(
                'Abdelrahman Mohamed Emam',
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
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(24, 20, 20, 1),
    );
  }
}
