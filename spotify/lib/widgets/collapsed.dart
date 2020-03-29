import 'package:flutter/material.dart';
import '../Models/track.dart';

class Collapsed extends StatefulWidget {

  final Track song;
  final StreamBuilder playButton;
  final StreamBuilder bar;

  Collapsed({this.song, this.playButton, this.bar});

  @override
  _CollapsedState createState() => _CollapsedState();
}

class _CollapsedState extends State<Collapsed> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height * 0.08,
      color: Color.fromRGBO(80, 80, 80, 1),
      child: Column(
        children: <Widget>[
          widget.bar,
          Row(
            children: <Widget>[
              Image.network(
                widget.song.imgUrl,
                height: deviceSize.height * 0.08,
              ),
              SizedBox(
                width: deviceSize.width * 0.03,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.song.artists[0].name,
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.05,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.song.name,
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.03,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: deviceSize.width * 0.4,
              ),
              widget.playButton,
              /*IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: deviceSize.height * 0.05,
                )
              )*/
            ],
          )
        ],
      ),
    );
  }
}
