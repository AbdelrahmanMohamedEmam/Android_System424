import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../../Models/album.dart';
import '../../Providers/album_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/album_widget_artist_mode.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../Screens/MainApp/tab_navigator.dart';


class MyMusicScreen extends StatefulWidget {
  static const   routeName='//my_music_screen';

  @override
  _MyMusicScreenState createState() => _MyMusicScreenState();
}

class _MyMusicScreenState extends State<MyMusicScreen> {
  bool _initialized = false;
  bool _success= true;
  String _currentTime;
  File imageURI;

  final albumNameController = TextEditingController();
  final albumTypeController =TextEditingController();
  final currentTimeController =TextEditingController();
  String artistImage =
      "https://img.discogs.com/HSUEWRWhz_K3_6ycQh0p4LdH_D0=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4105059-1573135200-3103.jpeg.jpg";
  bool _isInit = true;
  List<Album> albums;



  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<AlbumProvider>(context, listen: false)
          .fetchPopularAlbums();
      //_initPlatformState();
      _isInit = false;
      super.didChangeDependencies();
    }
  }
  void _goToCreateAlbum(BuildContext ctx ,)
  {
    Navigator.of(ctx).pushNamed(TabNavigatorRoutes.addAlbumScreen,);
  }

  void reloadAlbums()
  {
    setState(() {
      didChangeDependencies();
    });
  }
 /* void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    currentTimeController.dispose();
    albumNameController.dispose();
    albumTypeController.dispose();
    super.dispose();
  }

  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file":
      await MultipartFile.fromFile(file.path, filename:fileName),
    });
    response = await dio.post("/info", data: formData);
    return response.data['id];}*/

  @override
  Widget build(BuildContext context) {
    print('my music built');
    final deviceSize = MediaQuery.of(context).size;
    final albumProvider = Provider.of<AlbumProvider>(context , listen: false);
    albums = albumProvider.getPopularAlbums;
    reloadAlbums();
      return
        Scaffold(
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
                    onPressed: () =>_goToCreateAlbum(context),
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
      );
  }
}