import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
//import '../../Providers/album_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/album_provider.dart';
import '../../Providers/user_provider.dart';

class EditSongScreen extends StatefulWidget {
  final  albumId;
  final trackId;
  EditSongScreen({this.albumId , this.trackId});

  ///route name to get to the screen from navigator.
  static const routeName = '//edit_song_screen';

  _EditSongScreenState createState() => new _EditSongScreenState();
}

class _EditSongScreenState extends State<EditSongScreen> {

  ///controller for song name.
  final songNameController = TextEditingController();

  void initState() {
    super.initState();
  }

  void _editSong(BuildContext ctx , String _userToken ) async
  {
    final deviceSize = MediaQuery.of(context).size;
    bool check =
    await Provider.of<AlbumProvider>(context , listen: false)
        .editSong(_userToken ,songNameController.text , widget.albumId , widget.trackId );
    setState(() {
      if(check)
      {
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Container(
                    height: deviceSize.height*0.1,
                    child: Text("Song edited successfuly!"))));
        Navigator.of(ctx).pop();
        print('popped');
      }
      else
      {
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Container(
                    height: deviceSize.height*0.1,
                    child: Text("something went wrong ,please try again!"))));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    String _user = Provider.of<UserProvider>(context, listen: false).token;
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Rename Song'),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: deviceSize.width * 0.01, right: deviceSize.width * 0.01),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: deviceSize.width * 0.02,
                          bottom: deviceSize.width * 0.02,
                          left: deviceSize.width * 0.2,
                          right: deviceSize.width * 0.2),
                      width: deviceSize.width * 0.4,
                      child: TextFormField(
                        controller: songNameController,
                        decoration: InputDecoration(
                          labelText: 'choose song name ',
                          filled: true,
                          fillColor: Colors.green[700],
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.black),
                        cursorColor: Theme.of(context).primaryColor,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: deviceSize.height * 0.03),
                      color: Colors.green,
                      child: IconButton(
                        focusColor: Colors.white,
                        onPressed: () =>_editSong(context , _user),
                        icon: Icon(
                          Icons.done_outline,
                        ),
                        iconSize: deviceSize.width * 0.1,
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
