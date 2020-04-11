///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';

///Importing the screens to navigate to it.
import 'check_email_screen.dart';

///Importing the user provider to access the user data.
import 'package:provider/provider.dart';
import '../../Providers/user_provider.dart';

///Importing the http exception model to throw an http exception.
import '../../Models/http_exception.dart';

///Importing this package to validate the email format.
import 'package:email_validator/email_validator.dart';


///A screen to get the user email to send him a change password code.
///[CheckEmailScreen] is called next if the process is completed successfully.
///The screen checks that the email is in the email format before sending the request to the backend.
class GetEmailScreen extends StatefulWidget {
  static const routeName = '/get_email_screen';
  @override
  _GetEmailScreenState createState() => _GetEmailScreenState();
}

class _GetEmailScreenState extends State<GetEmailScreen> {
  bool _validate;
  final emailController = TextEditingController();

  @override
  void initState() {
    _validate = true;
    super.initState();
  }

  ///A function to show an error dialog when needed.
  void _showErrorDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Resetting password failed'),
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

  ///A function to call the request responsible for forgetting the password.
  Future<void> _submit(String email) async {
    final _auth = Provider.of<UserProvider>(context, listen: false);
    try {
      await _auth.forgetPassword(
        email,
      );

      ///Handling any error from the backend by showing a dialog.
    } on HttpException catch (error) {
      var errorMessage = error.toString();
      _showErrorDialog(errorMessage);

      ///Handling connection error or unplanned errors.
    } catch (error) {
      const errorMessage = 'Check the email address and try again.';
      _showErrorDialog(errorMessage);
      return;
    }

    ///Checks if the reset succeeded.
    if (_auth.resetSuccessful) {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, CheckEmailScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    ///Getting the device size.
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///'Email' Text.
          Container(
            margin: EdgeInsets.fromLTRB(25, 5, 0, 10),
            child: Text(
              'Email',
              style: TextStyle(color: Colors.white, fontSize: deviceSize.width*0.07),
            ),
          ),

          ///Text input field to take the email.
          Container(
            margin: EdgeInsets.only(left: 25, bottom: 10),
            width: deviceSize.width * 0.9,
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.grey,
                helperText: 'We\'ll send you an email to reset your password.',
                helperStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.white38),
              ),
              style: TextStyle(color: Colors.white),
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.emailAddress,
            ),
          ),

          ///Show an error text if needed.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _validate
                  ? SizedBox(
                      height: 0.1,
                    )
                  : Text(
                      'Please enter a valid Email',
                      style: TextStyle(color: Colors.red),
                    )
            ],
          ),

          ///'Get Link' Button.
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
                    'GET LINK',
                    style: TextStyle(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  onPressed: () {
                    ///Submitting the email to the request if it is valid.
                    bool isValid =
                        EmailValidator.validate(emailController.text);
                    if (emailController.text.isEmpty || !isValid) {
                      setState(() {
                        _validate = false;
                      });
                    } else {
                      _submit(emailController.text);
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
