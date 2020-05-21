import 'package:flutter/cupertino.dart';

///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:spotify/Providers/playable_track.dart';
import 'package:spotify/Widgets/album_widget_artist_mode.dart';

import '../../Models/track.dart';
import '../../Providers/track_provider.dart';

///Importing the user provider to access the user data.
import 'package:provider/provider.dart';
import '../../Providers/user_provider.dart';

///Importing the http exception model to throw an http exception.
import '../../Models/http_exception.dart';

class SongSettingsScreen extends StatefulWidget {
  static const routeName = '/song_settings_screen';
  Track song;
  SongSettingsScreen({this.song});

  @override
  _SongSettingsScreenState createState() => _SongSettingsScreenState();
}

class _SongSettingsScreenState extends State<SongSettingsScreen> {
  ///Initializations.
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Getting the device size.
    final deviceSize = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context, listen: false);
    final trackProvider =
        Provider.of<PlayableTrackProvider>(context, listen: false);

    ///If the screen is loading show a circular progress.
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image.network(widget.song.album.image,height: deviceSize.height*0.3,),
                      margin: EdgeInsets.only(
                        top: deviceSize.height * 0.1,
                      ),
                    ),
                    Container(
                      child: Text(
                        widget.song.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceSize.width * 0.04),
                      ),
                      margin: EdgeInsets.only(
                          top: deviceSize.height * 0.01,
                          bottom: deviceSize.height * 0.01),
                    ),
                    Container(
                      child: Text(
                        widget.song.artists[0].name,
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: deviceSize.width * 0.035),
                      ),
                      margin: EdgeInsets.only(
                          top: deviceSize.height * 0.005,
                          bottom: deviceSize.height * 0.05),
                    ),
                    Container(
                        child: InkWell(
                          onTap: ()async{
                            //print(widget.song.artists[0].artistInfo.biography);
                            await Share.share('Check Out This Album On Totally Not Spotify ' + widget.song.album.href.replaceAll('/api', ''));
                          },
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.fromLTRB(20, 20, 5, 20),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(40, 20, 10, 20),
                              child: Text(
                                'Share this album',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: deviceSize.width * 0.05),
                              ))
                        ],
                      ),
                    ),
                    ),
                    Container(
                        child: InkWell(
                          onTap: ()async{
                            if (Provider.of<PlayableTrackProvider>(context, listen: false).isTrackLiked(widget.song.id))
                            {
                              await Provider.of<PlayableTrackProvider>(context, listen: false).unlikeTrack(user.token, widget.song.id)
                                  .then((_){setState(() {

                              });
                              });
                            }
                            else
                            {
                              await Provider.of<PlayableTrackProvider>(context, listen: false).likeTrack(user.token, widget.song).then((_){
                                setState(() {
                                });
                              });


                            }
                          },
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              trackProvider.isTrackLiked(widget.song.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.fromLTRB(20, 20, 5, 20),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(40, 20, 10, 20),
                              child: Text(
                                trackProvider.isTrackLiked(widget.song.id)
                                    ? 'Unlike this song'
                                    : 'Like this song',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: deviceSize.width * 0.05),
                              ))
                        ],
                      ),
                    )),
                    Container(
                      child: InkWell(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.fromLTRB(20, 20, 5, 20),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(40, 20, 10, 20),
                                child: Text(
                                  'View Artist',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: deviceSize.width * 0.05),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: (){
                          print(widget.song.artists[0].artistInfo.biography);
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.fromLTRB(20, 20, 5, 20),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(40, 20, 10, 20),
                                child: Text(
                                  'Show artist info',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: deviceSize.width * 0.05),
                                ))
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(

                child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      child: Text(
                        'CLOSE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: deviceSize.width * 0.035,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ))
          ],
        ));
  }
}
