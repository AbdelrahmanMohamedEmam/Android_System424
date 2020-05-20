import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/user_provider.dart';

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File pickedImageFile;
  UserProvider user;
  @override
  void didChangeDependencies() {
    user = Provider.of<UserProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  void _pickImage() async {}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: 20,
            bottom: 15,
          ),
          width: double.infinity,
          child: Container(
            width: 70.0,
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              backgroundImage: user.getpickedImage != null
                  ? FileImage(user.getpickedImage)
                  : null,
              radius: 70,
              child: Text(
                user.getpickedImage == null ? user.username[0] : "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 10,
          ),
          child: GestureDetector(
            onTap: () async {
              pickedImageFile =
                  await ImagePicker.pickImage(source: ImageSource.camera);
              setState(() {
                user.setUserPickedImage(pickedImageFile);
              });
            },
            child: Text(
              'CHANGE PHOTO',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
