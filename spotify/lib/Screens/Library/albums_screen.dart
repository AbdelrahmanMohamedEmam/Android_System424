//import packages
import 'package:flutter/material.dart';

class AlbumsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(90),
        child: Center(
          child: Text(
            'Albums you like will appear here',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
