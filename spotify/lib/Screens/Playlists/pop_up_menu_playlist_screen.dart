

import 'package:flutter/cupertino.dart';

///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:spotify/Models/playlist.dart';
import 'package:spotify/Providers/playlist_provider.dart';

///Importing the user provider to access the user data.
import 'package:provider/provider.dart';
import '../../Providers/user_provider.dart';


class PopUpMenuPlaylistScreen extends StatefulWidget {
  static const routeName = '/pop_up_menu_playlist_screen';
  Playlist playlist;
  PlaylistCategory category;
  PopUpMenuPlaylistScreen(this.playlist, this.category);

  @override
  _PopUpMenuPlaylistScreenState createState() =>
      _PopUpMenuPlaylistScreenState();
}

class _PopUpMenuPlaylistScreenState extends State<PopUpMenuPlaylistScreen> {
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
    final playlistProvider =
        Provider.of<PlaylistProvider>(context, listen: false);

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
                      child: Image.network(
                        widget.playlist.images[0],
                        height: deviceSize.height * 0.3,
                      ),
                      margin: EdgeInsets.only(
                        top: deviceSize.height * 0.1,
                      ),
                    ),
                    Container(
                      child: Text(
                        widget.playlist.name,
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
                        widget.playlist.owner[0].name,
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
                          //print(widget.song.artists[0].artistInfo.biography);
                          await Share.share(
                              'Check Out This Album On Totally Not Spotify ' +
                                  widget.playlist.href.replaceAll('/api', ''));
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
                                  'Share this playlist',
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
                        if (Provider.of<PlaylistProvider>(context,
                                listen: false)
                            .isPlaylistLiked(widget.playlist.id)) {
                          await Provider.of<PlaylistProvider>(context,
                                  listen: false)
                              .unlikePlaylist(user.token, widget.playlist.id)
                              .then((_) {
                            setState(() {});
                          });
                        } else {
                          await Provider.of<PlaylistProvider>(context,
                                  listen: false)
                              .likePlaylist(user.token, widget.playlist.id,
                                  widget.category)
                              .then((_) {
                            setState(() {});
                          });
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              playlistProvider
                                      .isPlaylistLiked(widget.playlist.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.fromLTRB(20, 20, 5, 20),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(40, 20, 10, 20),
                              child: Text(
                                playlistProvider
                                        .isPlaylistLiked(widget.playlist.id)
                                    ? 'Unlike this playlist'
                                    : 'Like this playlist',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: deviceSize.width * 0.05),
                              ))
                        ],
                      ),
                    )),
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
              ),
            ),
            SizedBox(height: 50),
          ],
        ));
  }
}
