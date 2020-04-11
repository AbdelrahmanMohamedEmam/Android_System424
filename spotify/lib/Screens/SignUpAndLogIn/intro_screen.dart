///Importing the package to use UI libraries.
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart' as fb;

///Importing the user provider to access the user data.
import 'package:provider/provider.dart';
import 'package:spotify/Widgets/trackPlayer.dart';
import '../../Providers/user_provider.dart';

///Importing the http exception model to throw an http exception.
import '../../Models/http_exception.dart';

///Importing the screens to navigate to it.
import '../../Screens/SignUpAndLogIn/create_email_screen.dart';
import 'logIn_screen.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro_screen';
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

///This is the first screen that appears if the user is opening the app for the first time.
///It shows him the sign up/login/login with facebook options.
///Either [LogInScreen] or [CreateEmailScreen] is called next.
class _IntroScreenState extends State<IntroScreen> {
  ///Showing an error dialog when needed.
  void _showErrorDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Logging in Failed'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  ///Called when user is logging with facebook.
  Future<void> _submit() async {
    ///Instantiating a user provider object.
    final _auth = Provider.of<UserProvider>(context, listen: false);
    try {
      ///Calling facebook API and try to login.
      await _auth.signInWithFB();

      ///Handling any error from the backend by showing a dialog.
    } on HttpException catch (error) {
      var errorMessage = error.toString();
      _showErrorDialog(errorMessage);

      ///Handling connection error or unplanned errors.
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
      return;
    }

    ///Checking if the login succeeded.
    if (_auth.isFbLogin) {
      ///Filling the info of the user to use it later in the application.
      try {
        await _auth.setUser(_auth.token);

        ///Handling any error from the backend by showing a dialog.
      } on HttpException catch (error) {
        var errorMessage = error.toString();
        _showErrorDialog(errorMessage);
        return;

        ///Handling connection error or unplanned errors.
      } catch (error) {
        const errorMessage =
            'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
        return;
      }

      ///Pushing the main screen.
      Navigator.of(context).pushReplacementNamed(MainWidget.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    ///Getting the size of the screen.
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///Spotify logo.
          Container(
            child: Image.asset('assets/images/spotify_logo.jpg'),
            margin: EdgeInsets.fromLTRB(20, 50, 10, 10),
            height: deviceSize.height * 0.10,
          ),
          SizedBox(
            height: deviceSize.height * 0.15,
          ),

          ///'Millions of songs' Text.
          Container(
            margin: EdgeInsets.fromLTRB(deviceSize.width * 0.05, 10, 10, 5),
            child: Text(
              'Millions of songs.',
              style: TextStyle(
                  fontSize: deviceSize.width * 0.08,
                  color: Colors.white,
                  fontFamily: 'Lineto'),
              textAlign: TextAlign.left,
            ),
          ),

          ///'Free on Spotify' Text.
          Container(
            margin: EdgeInsets.fromLTRB(deviceSize.width * 0.05, 5, 10, 10),
            child: Text(
              'Free on Spotify.',
              style: TextStyle(
                  fontSize: deviceSize.width * 0.08,
                  color: Colors.white,
                  fontFamily: 'Lineto'),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: deviceSize.height * 0.20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ///Sign Up Free Button.
              Container(
                width: deviceSize.width * 0.8,
                height: deviceSize.height * 0.065,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.green[700],
                  child: Text(
                    'SIGN UP FREE',
                    style: TextStyle(fontSize: deviceSize.width * 0.045),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    //side: BorderSide(color: Colors.green),
                  ),
                  onPressed: () {
                    ///Pushing the email screen when pressed.
                    Navigator.pushNamed(context, CreateEmailScreen.routeName);
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ///Continue with facebook button.
              Container(
                  margin: EdgeInsets.only(top: 15),
                  width: deviceSize.width * 0.8,
                  height: deviceSize.height * 0.065,
                  child: fb.FacebookSignInButton(
                    borderRadius: 20.0,
                    onPressed: () {
                      _submit();
                    },
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ///Login Button.
              FlatButton(
                child: Text(
                  'LOG IN',
                  style: TextStyle(
                      fontSize: deviceSize.width * 0.045,
                      color: Colors.grey,
                      decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LogInScreen.routeName);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
