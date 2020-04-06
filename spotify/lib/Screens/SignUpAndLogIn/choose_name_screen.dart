///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';

///Importing the user provider to access the user data.
import 'package:provider/provider.dart';
import '../../Providers/user_provider.dart';

///Importing the screens to navigate to it.
import 'package:spotify/Screens/SignUpAndLogIn/choose_fav_artists.screen.dart';

///Importing the http exception model to throw an http exception.
import '../../Models/http_exception.dart';

class ChooseNameScreen extends StatefulWidget {
  static const routeName = '/choose_name_screen';
  @override
  _ChooseNameScreenState createState() => _ChooseNameScreenState();
}

class _ChooseNameScreenState extends State<ChooseNameScreen> {
  final username = TextEditingController();
  bool _validate;

  @override
  void initState() {
    _validate = true;
    super.initState();
  }

  void _showErrorDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Registration Failed'),
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
      await _auth.signUp(
        userData['email'],
        userData['password'],
        userData['gender'],
        userData['dateOfBirth'],
        username.text,
      );
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
      }catch(error){
        const errorMessage =
            'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
        return;
      }
      //Navigator.of(context).popUntil(ModalRoute.withName('/'));
      Navigator.of(context).pushNamed(ChooseFavArtists.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map userData = ModalRoute.of(context).settings.arguments as Map;
    final deviceSize = MediaQuery.of(context).size;
    final _user = Provider.of<UserProvider>(context, listen: false);
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
              'What\'s your name?',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            width: deviceSize.width * 0.9,
            child: TextFormField(
              controller: username,
              decoration: InputDecoration(
                labelText: 'Enter your username',
                filled: true,
                fillColor: Colors.grey,
                helperText: _validate
                    ? 'This appears on your spotify profile.'
                    : 'Please enter a valid username, this username may be taken',
                helperStyle:
                    TextStyle(color: _validate ? Colors.grey : Colors.red),
                labelStyle: TextStyle(color: Colors.white38),
              ),
              style: TextStyle(color: Colors.white),
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.emailAddress,
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
                    'CREATE',
                    style: TextStyle(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  onPressed: () {

                    if (username.text.isEmpty) {
                      setState(() {
                        _validate = false;
                      });
                    } else {
                      _submit(userData);
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
