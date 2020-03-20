import 'dart:ui';
//import packages
import 'package:flutter/material.dart';

class ArtistsScreen extends StatelessWidget {
  void chooseArtistsButton() {
    print('button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: FlatButton.icon(
          onPressed: chooseArtistsButton,
          icon: Icon(
            Icons.control_point,
            color: Colors.grey,
            size: 40,
          ),
          label: Text(
            'Choose artists',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
