///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';

///Importing the screens to navigate to it.
import 'add_birthdate_screen.dart';

///This screen is called when signing up after the [CreateEmailScreen].
///It checks that the entered password is more than 7 characters.
///[AddBirthDateScreen] is called when the NEXT button is pressed if the password is valid.
class CreatePasswordScreen extends StatefulWidget {
  static const routeName = '/create_password_screen';

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  ///Indicates if the password is visible or the user or not.
  bool _passwordVisible;

  ///Indicates if the data is validated or not.
  bool _validate;

  ///Text controller to keep track with the password field.
  final passwordController = TextEditingController();

  ///Initialization.
  @override
  void initState() {
    _passwordVisible = false;
    _validate = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Getting the email from the previous screen.
    final email = ModalRoute.of(context).settings.arguments as String;

    ///Getting the device size.
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
          ///'Create a password' text.
          Container(
            margin: EdgeInsets.fromLTRB(
                deviceSize.width * 0.06, 5, 0, deviceSize.width * 0.04),
            child: Text(
              'Create a password',
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
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
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
                    'NEXT',
                    style: TextStyle(fontSize: deviceSize.width * 0.04),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  onPressed: () {
                    if (passwordController.text.length >= 8) {
                      ///Pushing the add birth date screen.
                      Navigator.pushNamed(context, AddBirthDateScreen.routeName,
                          arguments: {
                            'email': email,
                            'password': passwordController.text
                          });
                    } else {
                      setState(() {
                        _validate = false;
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
