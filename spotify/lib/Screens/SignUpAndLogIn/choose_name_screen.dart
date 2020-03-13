import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/authorization_provider.dart';
import '../../Providers/user_provider.dart';



class ChooseNameScreen extends StatefulWidget {
  static const routeName = '/choose_name_screen';
  @override
  _ChooseNameScreenState createState() => _ChooseNameScreenState();
}

class _ChooseNameScreenState extends State<ChooseNameScreen> {
  final username= TextEditingController();
  bool _validate;

  @override
  void initState() {
    _validate=true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map userData = ModalRoute.of(context).settings.arguments as Map;
    final deviceSize = MediaQuery.of(context).size;
    final _auth = Provider.of<AuthorizationProvider>(context, listen: false);
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
                helperText: _validate?'This appears on your spotify profile.':'Please enter a valid username, this username may be taken',
                helperStyle: TextStyle(color: _validate?Colors.grey:Colors.red),
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
                    //Check username isn't taken

                    if (username.text.isEmpty) {
                      setState(() {
                        _validate = false;
                      });
                    } else {
                      try {
                        _auth.signUp(
                          userData['email'],
                          userData['password'],
                          userData['gender'],
                          userData['dateOfBirth'],
                          username.text,
                        );
                        try {
                          _user.setUser(_auth.token);
                          //NAVIGATE TO HOME SCREEN

                        } catch (error) {
                          //LOST CONNECTION ERROR
                        }
                      } catch (error) {
                        setState(() {
                          _validate = false;
                        });
                      }
                    }
                  },
                ),
              ),
            ],)
        ],
      ),
    );
  }
}
