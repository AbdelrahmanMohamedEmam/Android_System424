import 'package:flutter/cupertino.dart';

///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:spotify/Models/album.dart';
import 'package:spotify/Providers/album_provider.dart';
import 'package:spotify/Screens/ArtistProfile/artist_profile_screen.dart';

///Importing the user provider to access the user data.
import 'package:provider/provider.dart';
import '../../Providers/user_provider.dart';

///Importing the http exception model to throw an http exception.

class PopUpMenuAlbumScreen extends StatefulWidget {
  static const routeName = '/pop_up_menu_album_screen';
  final Album album;
  final AlbumCategory category;
  PopUpMenuAlbumScreen(this.album, this.category);

  @override
  _PopUpMenuAlbumScreenState createState() => _PopUpMenuAlbumScreenState();
}

class _PopUpMenuAlbumScreenState extends State<PopUpMenuAlbumScreen> {
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
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);

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
                        widget.album.image,
                        height: deviceSize.height * 0.3,
                      ),
                      margin: EdgeInsets.only(
                        top: deviceSize.height * 0.1,
                      ),
                    ),
                    Container(
                      child: Text(
                        widget.album.name,
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
                        widget.album.artists[0].name,
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
                                  widget.album.href.replaceAll('/api', ''));
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
                        if (Provider.of<AlbumProvider>(context, listen: false)
                            .isAlbumLiked(widget.album.id)) {
                          await Provider.of<AlbumProvider>(context,
                                  listen: false)
                              .unlikeAlbum(user.token, widget.album.id)
                              .then((_) {
                            setState(() {});
                          });
                        } else {
                          await Provider.of<AlbumProvider>(context,
                                  listen: false)
                              .likeAlbum(
                                  user.token, widget.album.id, widget.category)
                              .then((_) {
                            setState(() {});
                          });
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              albumProvider.isAlbumLiked(widget.album.id)
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
                                albumProvider.isAlbumLiked(widget.album.id)
                                    ? 'Unlike this album'
                                    : 'Like this album',
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
                                      id: widget.album.artists[0].id,
                                    )));
                          }),
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
              ),
            ),
            SizedBox(height: deviceSize.height * 0.07320644),
          ],
        ));
  }
}
