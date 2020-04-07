///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ///Indicates if the password is visible or the user or not.
  bool _passwordVisible;

  bool _confirmPasswordVisible;

  ///Indicates if the data is validated or not.
  bool _validate;

  bool _matching;

  ///Text controller to keep track with the password field.
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ///Initialization.
  @override
  void initState() {
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    _validate = true;
    _matching = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Getting the device size.
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Change password'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///'Create a password' text.
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceSize.width * 0.06, 5, 0, deviceSize.width * 0.04),
              child: Text(
                'Password',
                style: TextStyle(
                    color: Colors.white, fontSize: deviceSize.width * 0.06),
              ),
            ),

            ///Text Input Field for the password.
            Container(
              margin: EdgeInsets.only(left: deviceSize.width * 0.06),
              width: deviceSize.width * 0.9,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.grey,
                  helperText: 'Use at least 8 characters.',
                  helperStyle:
                      TextStyle(color: _validate ? Colors.grey : Colors.red),
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
                controller: passwordController,
              ),
            ),

            ///'Create a password' text.
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceSize.width * 0.06, 5, 0, deviceSize.width * 0.04),
              child: Text(
                'Change Password',
                style: TextStyle(
                    color: Colors.white, fontSize: deviceSize.width * 0.06),
              ),
            ),

            ///Text Input Field for the password.
            Container(
              margin: EdgeInsets.only(left: deviceSize.width * 0.06),
              width: deviceSize.width * 0.9,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  filled: true,
                  fillColor: Colors.grey,
                  helperText:
                      _matching ? '' : 'Please enter a matching password',
                  helperStyle: TextStyle(color: Colors.red),
                  labelStyle: TextStyle(color: Colors.white38),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white38,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_confirmPasswordVisible,
                style: TextStyle(color: Colors.white),
                cursorColor: Theme.of(context).primaryColor,
                controller: confirmPasswordController,
              ),
            ),

            ///Next button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: deviceSize.width * 0.06),
                  width: deviceSize.width * 0.4,
                  height: deviceSize.height * 0.065,
                  child: RaisedButton(
                    textColor: Theme.of(context).accentColor,
                    color: Colors.grey,
                    child: Text(
                      'SAVE',
                      style: TextStyle(fontSize: deviceSize.width * 0.04),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    onPressed: () {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        _matching = true;
                        if (passwordController.text.length >= 8) {
                        } else {
                          _validate = false;
                        }
                      } else {
                        _matching = false;
                      }
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
