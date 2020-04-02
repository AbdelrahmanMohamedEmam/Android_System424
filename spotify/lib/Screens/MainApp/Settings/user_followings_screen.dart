import 'package:flutter/material.dart';

class UserFollowingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 2),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(48, 44, 44, 1),
        centerTitle: true,
        title: Text(
          'Following',
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
