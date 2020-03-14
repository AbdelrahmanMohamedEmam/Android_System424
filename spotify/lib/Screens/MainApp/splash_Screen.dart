import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  static const routeName = '/splash_screen';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
       child:
          Container(
            height: deviceSize.height*0.6,
            child: Image.asset('assets/images/splash_spotify.jpg',),
          )
      ),
    );
  }
}
