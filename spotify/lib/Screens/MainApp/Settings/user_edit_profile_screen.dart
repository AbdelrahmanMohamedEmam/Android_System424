import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import '../tab_navigator.dart';

class UserEditProfileScreen extends StatelessWidget {
  final userNameEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    userNameEditingController.text = user.username;
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 20, 20, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(24, 20, 20, 1),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text(
              'SAVE',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 20,
              bottom: 15,
            ),
            width: double.infinity,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 70,
              child: Text(
                user.username[0],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              'CHANGE PHOTO',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 350,
            child: TextField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              controller: userNameEditingController,
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.white,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'This could be your first name or a nickame.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            'It is how you will appear on Spotify.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 38,
            width: 200,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(TabNavigatorRoutes.changePasswordScreen);
              },
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'CHANGE PASSWORD',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
