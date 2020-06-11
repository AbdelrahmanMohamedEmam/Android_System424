import 'package:flutter/cupertino.dart';

///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:spotify/Providers/playable_track.dart';
import 'package:spotify/Providers/playlist_provider.dart';
import 'package:spotify/Screens/ArtistProfile/Song_Artist_Info_Screen.dart';
import 'package:spotify/Screens/ArtistProfile/artist_profile_screen.dart';

import '../../Models/track.dart';

///Importing the user provider to access the user data.
import 'package:provider/provider.dart';
import '../../Providers/user_provider.dart';

///Importing the http exception model to throw an http exception.

class SongItemPopUpMenu extends StatefulWidget {
  static const routeName = '/song_settings_screen';
  final Track song;
  SongItemPopUpMenu(this.song);

  @override
  _SongItemPopUpMenuState createState() => _SongItemPopUpMenuState();
}

class _SongItemPopUpMenuState extends State<SongItemPopUpMenu> {
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
    //final playlistProvider =
        Provider.of<PlaylistProvider>(context, listen: false);

    ///If the screen is loading show a circular progress.
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.network(
                      widget.song.album.image,
                      height: deviceSize.height * 0.25,
                    ),
                    margin: EdgeInsets.only(
                      top: deviceSize.height * 0.075,
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
                      onTap: () async {
                        await Share.share(
                            'Check Out This Album On Totally Not Spotify ' +
                                widget.song.album.href.replaceAll('/api', ''));
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.fromLTRB(
                              deviceSize.width * 0.04866,
                              deviceSize.height * 0.02928,
                              deviceSize.width * 0.012165,
                              deviceSize.height * 0.02928,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(
                                deviceSize.width * 0.09732,
                                deviceSize.height * 0.02928,
                                deviceSize.width * 0.02433,
                                deviceSize.height * 0.02928,
                              ),
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
                    onTap: () async {
                      if (Provider.of<PlayableTrackProvider>(context,
                              listen: false)
                          .isTrackLiked(widget.song.id)) {
                        await Provider.of<PlayableTrackProvider>(context,
                                listen: false)
                            .unlikeTrack(user.token, widget.song.id)
                            .then((_) {
                          setState(() {});
                        });
                      } else {
                        await Provider.of<PlayableTrackProvider>(context,
                                listen: false)
                            .likeTrack(user.token, widget.song)
                            .then((_) {
                          setState(() {});
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
                          margin: EdgeInsets.fromLTRB(
                            deviceSize.width * 0.04866,
                            deviceSize.height * 0.02928,
                            deviceSize.width * 0.012165,
                            deviceSize.height * 0.02928,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(
                              deviceSize.width * 0.09732,
                              deviceSize.height * 0.02928,
                              deviceSize.width * 0.02433,
                              deviceSize.height * 0.02928,
                            ),
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
                              margin: EdgeInsets.fromLTRB(
                                deviceSize.width * 0.04866,
                                deviceSize.height * 0.02928,
                                deviceSize.width * 0.012165,
                                deviceSize.height * 0.02928,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(
                                  deviceSize.width * 0.09732,
                                  deviceSize.height * 0.02928,
                                  deviceSize.width * 0.02433,
                                  deviceSize.height * 0.02928,
                                ),
                                child: Text(
                                  'View Artist',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: deviceSize.width * 0.05),
                                ))
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ArtistProfileScreen(
                                    id: widget.song.artists[0].id,
                                  )));
                        }),
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => InfoScreen(
                                  bio: widget
                                      .song.artists[0].artistInfo.biography,
                                  imageUrl: widget.song.artists[0].images[0],
                                  name: widget.song.artists[0].name,
                                )));
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.fromLTRB(
                              deviceSize.width * 0.04866,
                              deviceSize.height * 0.02928,
                              deviceSize.width * 0.012165,
                              deviceSize.height * 0.02928,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              deviceSize.width * 0.09732,
                              deviceSize.height * 0.02928,
                              deviceSize.width * 0.02433,
                              deviceSize.height * 0.02928,
                            ),
                            child: Text(
                              'Show artist info',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: deviceSize.width * 0.05),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
              ),
            ),
            SizedBox(height: deviceSize.height * 0.07320644),
          ],
        ));
  }
}
