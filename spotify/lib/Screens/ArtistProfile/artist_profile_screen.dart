import '../../widgets/album_widget_artist_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArtistProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.black87,
          child: ListView(
            children : <Widget> [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FlatButton(child :
                  Text('Follow!!'),
                    textColor: Colors.red,
                    color: Colors.grey,
                    onPressed : () {},
                  ),
                  IconButton(icon : Icon(Icons.more_vert),
                    onPressed: () {}, //will open a follow menu
                  ),

                ],),
              Container(
                height: 40,
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child : Text('SHUFFLE PLAY',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  //textColor: Colors.red,

                  //color: Colors.grey,
                  onPressed : () {},
                ),
              ),
              Container(
                height: 120,
                padding: EdgeInsets.only(left: 20, right: 20 , top: 30 , bottom: 30),
                //color: Colors.black87,
                child: FlatButton(child :
                Text('Artist songs'),     //to be filled with artist's features songs
                  textColor: Colors.white,

                  onPressed : () {},

                ),
              ),
              Text('Popular releases' ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              //new widget file for albums (4 albums )
              LoadingAlbumsWidget(),
              //Image.asset('assets/images11/test.png',
              //    fit : BoxFit.cover
              // ),





            ],
          ),
        )



    );
  }
}






