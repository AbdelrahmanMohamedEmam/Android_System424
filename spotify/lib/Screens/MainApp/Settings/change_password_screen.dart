///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/user_provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ///Indicates if the password is visible or the user or not.
  bool _passwordVisible;

  ///Indicates if the password confirmation visible or the user or not.
  bool _confirmPasswordVisible;

  ///Indicates if the old data is validated or not.
  bool _validateOld;

  ///Indicates if the new data is validated or not.
  bool _validateNew;

  ///Text controller to keep track with the password field.
  final oldPasswordController = TextEditingController();

  ///Text controller to keep track with the new password field.
  final newPasswordController = TextEditingController();

  ///Initialization.
  @override
  void initState() {
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    _validateOld = true;
    _validateNew = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Getting the device size.
    final deviceSize = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context, listen: false);
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
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceSize.width * 0.06, 5, 0, deviceSize.width * 0.04),
              child: Text(
                'Old Password',
                style: TextStyle(
                    color: Colors.white, fontSize: deviceSize.width * 0.06),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: deviceSize.width * 0.06),
              width: deviceSize.width * 0.9,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Old password',
                  filled: true,
                  fillColor: Colors.grey,
                  helperText: 'Use at least 8 characters.',
                  helperStyle:
                      TextStyle(color: _validateOld ? Colors.grey : Colors.red),
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
                controller: oldPasswordController,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceSize.width * 0.06, 5, 0, deviceSize.width * 0.04),
              child: Text(
                'Change Password',
                style: TextStyle(
                    color: Colors.white, fontSize: deviceSize.width * 0.06),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: deviceSize.width * 0.06),
              width: deviceSize.width * 0.9,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'New Password',
                  filled: true,
                  fillColor: Colors.grey,
                  helperText: 'Use at least 8 characters.',
                  helperStyle: _validateNew
                      ? TextStyle(color: Colors.grey)
                      : TextStyle(color: Colors.red),
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
                controller: newPasswordController,
              ),
            ),
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
                      setState(() {
                        if (oldPasswordController.text.length > 7) {
                          if (newPasswordController.text.length > 7) {
                            user.changePassword(
                                user.token,
                                newPasswordController.text,
                                oldPasswordController.text);
                          } else {
                            _validateNew = false;
                          }
                        } else {
                          _validateOld = false;
                        }
                      });
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

  // void _showErrorDialog(String message, String title) {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: Text(title),
  //       content: Text(message),
  //       actions: <Widget>[
  //         FlatButton(
  //           child: Text('Okay'),
  //           onPressed: () {
  //             Navigator.of(ctx).pop();
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
}
