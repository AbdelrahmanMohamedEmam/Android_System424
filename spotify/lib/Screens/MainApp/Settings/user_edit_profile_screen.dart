import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/widgets/image_picker_widget.dart';
import '../tab_navigator.dart';

class UserEditProfileScreen extends StatefulWidget {
  @override
  _UserEditProfileScreenState createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  bool changed = false;
  final userNameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     final deviceSize = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context, listen: false);
    userNameEditingController.text = user.username;
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 20, 20, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(24, 20, 20, 1),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              try {
                await user.changeUserName(
                    user.token,
                    user.userEmail,
                    userNameEditingController.text,
                    user.userGender,
                    user.userDateOfBirth);
              } catch (error) {
                _showErrorDialog(error.toString());
              }
            },
            child: Text(
              'SAVE',
              style:TextStyle(color: Colors.white),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: Column(
        children: <Widget>[
          ImagePickerWidget(),
          Container(
            width: deviceSize.width*0.852,
            child: TextFormField(
              enabled: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              controller: userNameEditingController,
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.white,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: deviceSize.height*0.0440,
          ),
          Text(
            'This could be your first name or a nickame.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            'It is how you will appear on Spotify.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: deviceSize.height*0.02929,
          ),
          Container(
            height: deviceSize.height*0.05564,
            width: deviceSize.width*0.4867,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(TabNavigatorRoutes.changePasswordScreen);
              },
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'CHANGE PASSWORD',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Message"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
