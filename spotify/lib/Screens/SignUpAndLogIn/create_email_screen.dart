///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';

///Importing the screens to navigate to it.
import 'create_password_screen.dart';

///Importing this package to validate the email format.
import 'package:email_validator/email_validator.dart';



class CreateEmailScreen extends StatefulWidget {
  static const routeName = '/create_email_screen';
  @override
  _CreateEmailScreenState createState() => _CreateEmailScreenState();
}

class _CreateEmailScreenState extends State<CreateEmailScreen> {

  final emailController= TextEditingController();
  bool _validate;


  @override
  void initState() {
    _validate=true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              'What\'s your email?',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            width: deviceSize.width * 0.9,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'E-Mail',
                filled: true,
                fillColor: Colors.grey,
                helperText: 'Please enter a valid email.',
                helperStyle: TextStyle(color: _validate?Colors.grey:Colors.red),
                labelStyle: TextStyle(color: Colors.white38),
              ),
              style: TextStyle(color: Colors.white),
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
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
                'NEXT',
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
              onPressed: () {
                bool isValid = EmailValidator.validate(emailController.text);
                if (isValid==true)
                   Navigator.pushNamed(context,CreatePasswordScreen.routeName, arguments: emailController.text);
                else {
                  setState(() {
                    _validate = false;
                  });

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
