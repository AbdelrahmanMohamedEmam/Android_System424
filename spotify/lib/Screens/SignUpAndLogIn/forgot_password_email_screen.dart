import 'package:flutter/material.dart';
import 'check_email_screen.dart';
import 'package:provider/provider.dart';
import '../../Providers/user_provider.dart';
import '../../Models/http_exception.dart';
import 'package:email_validator/email_validator.dart';

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

  Future<void> _submit(String email) async {
    final _auth=Provider.of<UserProvider>(context, listen: false);
    try {
      await _auth.forgetPassword(
        email,
      );
    } on HttpException catch (error) {
      var errorMessage = error.toString();
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Check the email address and try again.';
      _showErrorDialog(errorMessage);
      return;
    }
    if(_auth.resetSuccessful) {
      Navigator.pushNamed(
          context, CheckEmailScreen.routeName);
    }
    //Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    final _auth =  Provider.of<UserProvider>(context, listen: false);
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
          Container(
            margin: EdgeInsets.fromLTRB(25, 5, 0, 10),
            child: Text(
              'Email or Username',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, bottom: 10),
            width: deviceSize.width * 0.9,
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email or Username',
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
                    bool isValid = EmailValidator.validate(emailController.text);
                    if (emailController.text.isEmpty ||  !isValid) {
                      setState(() {
                        _validate = false;
                      });
                    } else {
                      _submit(emailController.toString());
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
