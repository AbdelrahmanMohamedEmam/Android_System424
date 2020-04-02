
import 'package:flutter/material.dart';
import '../../Models/album.dart';
import '../../Providers/album_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/album_widget_artist_mode.dart';
import 'package:true_time/true_time.dart';
class MyMusicScreen extends StatefulWidget {
  static const   routeName='/my_music_screen';

  @override
  _MyMusicScreenState createState() => _MyMusicScreenState();
}

class _MyMusicScreenState extends State<MyMusicScreen> {
  bool _initialized = false;
  String _currentTime = 'click on the time key to choose ';

  final albumNameController = TextEditingController();
  final copyRightsController =TextEditingController();
  String artistImage =
      "https://img.discogs.com/HSUEWRWhz_K3_6ycQh0p4LdH_D0=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4105059-1573135200-3103.jpeg.jpg";
  bool _isInit = true;
  List<Album> albums;

  void _updateCurrentTime()
  {
    setState(() {
      _currentTime = DateTime.now().day.toString() +
      '-' + DateTime.now().month.toString() + '-' +
      DateTime.now().year.toString();
    });

  }

  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<AlbumProvider>(
          context, listen: false)
          .fetchPopularAlbums(
      );
      //_initPlatformState();
      _isInit = false;
      super.didChangeDependencies();
    }
  }


  bool _isPressed = false;
  void _addNewAlbum()
  {
    setState(() {
      _isPressed = !_isPressed;
    });
  }
  @override
  Widget build(BuildContext context) {

    final deviceSize = MediaQuery.of(context).size;
    final albumProvider = Provider.of<AlbumProvider>(context , listen: false);
    albums = albumProvider.getPopularAlbums;
      return Stack(
        children: <Widget>[
       Visibility(
        visible: !_isPressed,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                  'my music screen'),
              actions: <Widget>[
                Container(
                  padding: EdgeInsets.all(
                      deviceSize.width * 0.03),
                  child: IconButton(
                    icon: Icon(
                      Icons.library_add,
                      color: Colors.white,
                      size: deviceSize.width * 0.08,
                    ),
                    onPressed: _addNewAlbum,
                  ),
                ),
              ],
            ),
            body: Container(
              color: Colors.black,
              height: double.infinity,
              width: double.infinity,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: deviceSize.height * 0.6,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: albums.length,
                      physics: const NeverScrollableScrollPhysics(
                      ), //to be replaced with fixed 4 items
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, i) =>
                          ChangeNotifierProvider.value(
                            value: albums[i],
                            child: ArtistModeAlbums(
                            ),
                          ),

                    ),
                  ),

                ],

              ),
            ),
          ),
       ),
          Positioned(
              top:deviceSize.height*0.1 ,
              bottom: deviceSize.height*0.1 ,
              left: deviceSize.width * 0.05,
              right: deviceSize.width * 0.05,
              child: Visibility(
                visible: _isPressed,
                  child: Scaffold(
                    body: ListView(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: _addNewAlbum,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:deviceSize.width*0.02 , bottom: deviceSize.width*0.02 , left: deviceSize.width*0.2 , right: deviceSize.width*0.2),
                          width: deviceSize.width * 0.4,
                          child: TextFormField(
                            controller: albumNameController,
                            decoration: InputDecoration(
                              labelText: 'Album name ',
                              filled: true,
                              fillColor: Colors.lightGreen,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            style: TextStyle(color: Colors.black),
                            cursorColor: Theme.of(context).primaryColor,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:deviceSize.width*0.02 , bottom: deviceSize.width*0.02 , left: deviceSize.width*0.2 , right: deviceSize.width*0.2),
                          width: deviceSize.width * 0.4,
                          child: TextFormField(
                            controller: copyRightsController,
                            decoration: InputDecoration(
                              labelText: 'Copy Rights ',
                              filled: true,
                              fillColor: Colors.lightGreen,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            style: TextStyle(color: Colors.black),
                            cursorColor: Theme.of(context).primaryColor,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:deviceSize.width*0.02 , bottom: deviceSize.width*0.02 , left: deviceSize.width*0.2 , right: deviceSize.width*0.2),
                          width: deviceSize.width * 0.4,
                          child: TextFormField(
                            controller: copyRightsController,
                            decoration: InputDecoration(
                              labelText: 'AlbumType ',
                              filled: true,
                              fillColor: Colors.lightGreen,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            style: TextStyle(color: Colors.black),
                            cursorColor: Theme.of(context).primaryColor,
                            keyboardType: TextInputType.text,
                          ),
                        ),

                        Row(
                          children: <Widget>[
                            FloatingActionButton(
                            tooltip: 'Get current time',
                            child: Icon(Icons.timer),
                            onPressed: _updateCurrentTime,

                            ),
                            Container(
                              margin: EdgeInsets.only(top:deviceSize.width*0.02 , bottom: deviceSize.width*0.02 , left: deviceSize.width*0.2 , right: deviceSize.width*0.2),
                              width: deviceSize.width * 0.4,
                              child: TextFormField(
                                controller: copyRightsController,
                                decoration: InputDecoration(
                                  labelText: _currentTime,
                                  filled: true,
                                  fillColor: Colors.lightGreen,
                                  labelStyle: TextStyle(color: Colors.white),
                                ),
                                style: TextStyle(color: Colors.black),
                                cursorColor: Theme.of(context).primaryColor,
                                keyboardType: TextInputType.text,
                              ),
                            ),


                          ],
                        ),

                      ],
                    ),
                  )
                ),
              ),

        ],
      );
  }
}