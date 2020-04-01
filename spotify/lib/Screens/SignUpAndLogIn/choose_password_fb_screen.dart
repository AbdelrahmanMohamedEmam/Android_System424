///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';


///Importing the screens to navigate to it.
import 'package:spotify/Screens/SignUpAndLogIn/choose_fav_artists.screen.dart';

class CreatePasswordFBScreen extends StatefulWidget {
  static const routeName = '/create_password_fb_screen';

  @override
  _CreatePasswordFBScreenState createState() => _CreatePasswordFBScreenState();
}

class _CreatePasswordFBScreenState extends State<CreatePasswordFBScreen> {
  bool _passwordVisible;
  bool _validate;
  final passwordController= TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
    _validate=true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final email = ModalRoute.of(context).settings.arguments as String;
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(25, 5, 0, 10),
            child: Text(
              'Create a password',
              style: TextStyle(color: Colors.white, fontSize: deviceSize.width*0.08),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 5, 0, 10),
            child: Text(
              'You can use this passowrd to login to your account later.',
              style: TextStyle(color: Colors.white, fontSize: deviceSize.width*0.03),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            width: deviceSize.width * 0.9,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey,
                helperText: 'Use at least 8 characters.',
                helperStyle: TextStyle(color: _validate?Colors.grey:Colors.red),
                labelStyle: TextStyle(color: Colors.white38),
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                    color: Colors.white38,),
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
              controller: passwordController,
            ),
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
                    'Sign Up',
                    style: TextStyle(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  onPressed: () {
                    if (passwordController.text.length>=8) {
                      Navigator.pushNamed(
                          context, ChooseFavArtists.routeName, arguments:
                      {
                        'email': email,
                        'password': passwordController.text
                      }
                      );
                    }
                    else{
                      setState(() {
                        _validate=false;
                      });
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
