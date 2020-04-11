import 'package:flutter/material.dart';
import '../Models/track.dart';


///This class is the panel that appears when the [Panel] is hidden.
///It shows the track name, album name, track picture and other data.
///It receive the status of the bar and tool bar from the [MainWidget] to be synchronized with [Hidden].

class Collapsed extends StatefulWidget {
  final Track song;
  final StreamBuilder playButton;
  final StreamBuilder bar;
  final double collapsedHeight;

  Collapsed({this.song, this.playButton, this.bar, this.collapsedHeight});

  @override
  _CollapsedState createState() => _CollapsedState();
}

class _CollapsedState extends State<Collapsed> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return widget.collapsedHeight == 0
        ? Container()
        : Container(
            height: widget.collapsedHeight, //deviceSize.height * 0.08,
            color: Color.fromRGBO(48, 44, 44, 1),
            child: Column(
              children: <Widget>[
                widget.bar,
                Row(
                  children: <Widget>[
                    FadeInImage(
                      image: NetworkImage(
                        widget.song.album.image,
                      ),
                      height: deviceSize.height * 0.08,
                      placeholder: AssetImage('assets/images/temp.jpg'),
                    ),
                    SizedBox(
                      width: deviceSize.width * 0.03,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: deviceSize.width*0.3,
                          child: Text(
                          widget.song.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: deviceSize.width * 0.04,
                            color: Colors.white,
                          ),
                        ),
                        ),

                        Text(
                          widget.song.artists[0].name,
                          style: TextStyle(
                            fontSize: deviceSize.width * 0.03,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: deviceSize.width * 0.3,
                    ),
                    widget.playButton,
                  ],
                )
              ],
            ),
          );
  }
}
