import 'package:flutter/material.dart';


class CheckEmailScreen extends StatelessWidget {
  static const routeName = 'check_email_screen';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget yur password'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(25, 5, 0, 10),
            child: Text(
              'Check you email',
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
            child: Text(
              'We sent an email with a link to reset your password, kindly check your email and visit our website.',textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(

                child: Image.asset('assets/images/check_email.png', height: deviceSize.height*0.2),
                margin: EdgeInsets.fromLTRB(20, 50, 10, 10),
              ),
            ],)
        ],
      ),
    );
  }
}


