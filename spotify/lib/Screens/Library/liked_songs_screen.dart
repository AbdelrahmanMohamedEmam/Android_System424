import 'package:flutter/material.dart';

class LikedSongsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "your liked songs data will be placed here",
          style: TextStyle(color: Colors.white, fontSize: 32),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
