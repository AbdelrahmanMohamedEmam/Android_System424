import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 20, 20, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(24, 20, 20, 1),
        title: Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
