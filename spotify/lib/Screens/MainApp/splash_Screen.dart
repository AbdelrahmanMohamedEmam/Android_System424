
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../Providers/user_provider.dart';

import '../../Widgets/trackPlayer.dart';
import '../SignUpAndLogIn/intro_screen.dart';





class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation<double> animation;

  bool dataUpdated;
  bool isAuth;


  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController= AnimationController(duration: Duration(milliseconds:700), vsync: this);
    animation=Tween<double>(begin: 150,end: 170).animate(CurvedAnimation(curve: Curves.easeInOut,parent: _animationController,));
    _animationController.addStatusListener((status){
      if(status==AnimationStatus.completed)
        {
          _animationController.repeat();
        }
    });
    _animationController.forward();
    dataUpdated=false;
    startTimer();
  }


  void startTimer() {
    Timer(Duration(seconds: 4), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void navigateUser() async{
    print(isAuth.toString());
    if (isAuth) {
      Navigator.of(context).pushReplacementNamed(MainWidget.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(IntroScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context, listen: false);
    if(!dataUpdated) {
      _user.tryAutoLogin();
      isAuth = _user.isAuth;
      dataUpdated=isAuth;
    }
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body:AnimatedBuilder(animation: _animationController,builder: (context, child) {
        return Center(
            child:Container(
          height: animation.value,
          child: Image.asset('assets/images/splash_spotify.jpg',),
        ));
      }
      ),
    );
  }
}
