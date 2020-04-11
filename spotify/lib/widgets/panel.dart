import 'package:flutter/material.dart';
import '../Models/track.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';




///This class is the panel that appears when the [Collapsed] is tapped.
///It shows the track name, album name, track picture and other data.
///It receive the status of the bar and tool bar from the [MainWidget] to be synchronized with [Collapsed].
class Panel extends StatefulWidget {
  final Function toHide;
  final Track song;
  final PanelController pc;
  final StreamBuilder bar;
  final StreamBuilder toolBar;
  Panel({this.song, this.pc, this.bar, this.toolBar, this.toHide});
  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  var panelState;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return widget.song == null
        ? Container(
            height: 0,
          )
        : Column(
            children: <Widget>[
              SizedBox(
                height: deviceSize.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: deviceSize.width * 0.02),
                    child: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                      iconSize: deviceSize.height * 0.05,
                      onPressed: () {
                        widget.pc.close();
                        widget.toHide(false);
                      },
                    ),
                  ),
                  Container(
                    child: Text(
                      widget.song.album.name,
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: deviceSize.width * 0.03),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white24,
                      ),
                      iconSize: deviceSize.height * 0.05,
                    ),
                  ),
                ],
              ),
              Container(
                height: deviceSize.height * 0.45,
                margin: EdgeInsets.only(
                    top: deviceSize.height * 0.05,
                    bottom: deviceSize.height * 0.05),
                child: Image.network(
                  widget.song.album.image,
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: deviceSize.width * 0.05,
                          bottom: deviceSize.height * .01),
                      child: Text(
                        widget.song.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceSize.width * 0.06),
                      ),
                    )
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: deviceSize.width * 0.065,
                        bottom: deviceSize.height * .02),
                    child: Text(
                      widget.song.artists[0].name,
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: deviceSize.width * 0.045),
                    ),
                  )
                ],
              ),
              widget.bar,
              widget.toolBar,
            ],
          );
  }
}
