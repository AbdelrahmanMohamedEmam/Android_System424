import 'package:flutter/material.dart';

class PlaylistsScreen extends StatelessWidget {
  void createPlaylistButton() {
    print('button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Create your first playlist',
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.all(3)),
              Text(
                'It\'s easy\',we\'ll help you.',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.all(10)),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
                onPressed: createPlaylistButton,
                child: Text(
                  'CREATE PLAYLIST',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
              )
            ],
          ),
        ));
  }
}
