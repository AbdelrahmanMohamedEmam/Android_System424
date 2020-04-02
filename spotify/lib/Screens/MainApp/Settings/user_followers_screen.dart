import 'package:flutter/material.dart';

class UserFollowersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 2),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(48, 44, 44, 1),
        centerTitle: true,
        title: Text(
          'Followers',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
