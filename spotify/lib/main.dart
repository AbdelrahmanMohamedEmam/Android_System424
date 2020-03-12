//Import Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//Import Providers

//Import Screens
import 'Screens/SignUpAndLogIn/add_birthdate_screen.dart';
import 'Screens/SignUpAndLogIn/check_email_screen.dart';
import 'Screens/SignUpAndLogIn/choose_gender_screen.dart';
import 'Screens/SignUpAndLogIn/choose_name_screen.dart';
import 'Screens/SignUpAndLogIn/create_email_screen.dart';
import 'Screens/SignUpAndLogIn/create_password_screen.dart';
import 'Screens/SignUpAndLogIn/forgot_password_email_screen.dart';
import 'Screens/SignUpAndLogIn/logIn_screen.dart';
import 'Screens/SignUpAndLogIn/intro_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.black,
        fontFamily: 'Lineto',
      ),
      home: IntroScreen(),
      routes: {
        CreateEmailScreen.routeName: (ctx)=>CreateEmailScreen(),
        CreatePasswordScreen.routeName: (ctx)=>CreatePasswordScreen(),
        AddBirthDateScreen.routeName: (ctx)=>AddBirthDateScreen(),
        ChooseGenderScreen.routeName: (ctx)=>ChooseGenderScreen(),
        ChooseNameScreen.routeName: (ctx)=>ChooseNameScreen(),
        LogInScreen.routeName: (ctx)=>LogInScreen(),
        GetEmailScreen.routeName:(ctx)=>GetEmailScreen(),
        CheckEmailScreen.routeName:(ctx)=>CheckEmailScreen(),
      },
    );
  }
}
