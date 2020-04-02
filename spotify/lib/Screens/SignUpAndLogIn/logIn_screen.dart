///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';

///Importing the http exception model to throw an http exception.
import '../../Models/http_exception.dart';

///Importing the screens to navigate to it.
import 'forgot_password_email_screen.dart';
import '../../Widgets/trackPlayer.dart';

///Importing the user provider to access the user data.
import 'package:provider/provider.dart';
import '../../Providers/user_provider.dart';

///Importing this package to validate the email format.
import 'package:email_validator/email_validator.dart';


class LogInScreen extends StatefulWidget {
  static const routeName = '/login_screen';
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _passwordVisible;
  bool _validate;
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
    _validate = true;
    super.initState();
  }



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

  Future<void> _submit(userData) async {
    final _auth=Provider.of<UserProvider>(context, listen: false);
    try {
      await _auth.signIn(
        userData['email'],
        userData['password'],
      );
      print('1');
    } on HttpException catch (error) {
      var errorMessage = error.toString();
      _showErrorDialog(errorMessage);
      return;
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
      return;
    }
    if(_auth.isLoginSuccessfully)
      {
        try {
          await _auth.setUser(_auth.token);
        }on HttpException catch (error) {
          var errorMessage = error.toString();
          _showErrorDialog(errorMessage);
          return;
        } catch(error){
          const errorMessage =
              'Could not authenticate you. Please try again later.';
          _showErrorDialog(errorMessage);
          return;
        }
        Navigator.of(context).pushReplacementNamed(MainWidget.routeName);
      }

  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _user = Provider.of<UserProvider>(context, listen: false);
    return  Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(25, 5, 0, 10),
            child: Text(
              'Email or Username',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            width: deviceSize.width * 0.9,
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.grey,
                labelStyle: TextStyle(color: Colors.white38),
              ),
              style: TextStyle(color: Colors.white),
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 20, 0, 5),
            child: Text(
              'Password',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 25, top: 5, bottom: 20),
                width: deviceSize.width * 0.9,
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.grey,
                    labelStyle: TextStyle(color: Colors.white38),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white38,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Theme.of(context).primaryColor,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _validate
                  ? SizedBox(height: deviceSize.height * 0.01)
                  : Text('Invalid uername or password',
                      style: TextStyle(color: Colors.red)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 25),
                width: deviceSize.width * 0.4,
                height: deviceSize.height * 0.065,
                child: RaisedButton(
                  textColor: Theme.of(context).accentColor,
                  color: Colors.grey,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  onPressed: () {
                    bool isValid = EmailValidator.validate(emailController.text);
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty || !isValid) {
                      setState(() {
                        _validate = false;
                      });
                    } else {
                      var userData={
                        'email':emailController.text,
                        'password':passwordController.text,
                      };
                      _submit(userData);
                    }
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15),
                width: deviceSize.width * 0.6,
                height: deviceSize.height * 0.05,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.transparent,
                  child: Text(
                    'Forgot Your Password?',
                    style: TextStyle(fontSize: 12),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                    side: BorderSide(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, GetEmailScreen.routeName);
                  },
                ),
              ),
            ],
          )
        ],
      ),
      ),
    );
  }
}
