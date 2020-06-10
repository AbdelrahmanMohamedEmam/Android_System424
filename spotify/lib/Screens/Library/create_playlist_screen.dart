import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/Screens/Playlists/created_playlist_screen.dart';

class CreatePlaylistScreen extends StatefulWidget {
  @override
  _CreatePlaylistScreenState createState() => _CreatePlaylistScreenState();
}

class _CreatePlaylistScreenState extends State<CreatePlaylistScreen> {
  ///Text controller to keep track with the name field.
  final nameController = TextEditingController();
  bool _buttonEnabled;
  String id;
  @override
  void initState() {
    _buttonEnabled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final playlist = Provider.of<PlaylistProvider>(context, listen: false);
    UserProvider user = Provider.of<UserProvider>(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: deviceSize.height*0.263543, bottom: deviceSize.height*0.073206),
                  child: Text(
                    "Give your playlist a name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Theme(
              data: new ThemeData(
                primaryColor: Colors.white24,
                primaryColorDark: Colors.white24,
              ),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLength: null,
                maxLines: null,
                controller: nameController,
                onChanged: (text) {
                  if (nameController.text == "") {
                    setState(() {
                      _buttonEnabled = false;
                    });
                  } else {
                    setState(() {
                      _buttonEnabled = true;
                    });
                  }
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: deviceSize.height*0.073206),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              FlatButton(
                onPressed: _buttonEnabled
                    ? () async {
                        try {
                          id = await playlist.createPlaylist(
                              nameController.text, user.token);

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => CreatedPlaylistScreen(id),
                            ),
                          );
                        } catch (error) {
                          _showErrorDialog(error.toString());
                        }
                      }
                    : null,
                child: Text(
                  'Create',
                  style: TextStyle(
                      color: _buttonEnabled ? Colors.white : Colors.grey,
                      fontSize: 18),
                ),
              ),
            ],
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
            },
          )
        ],
      ),
    );
  }
}
