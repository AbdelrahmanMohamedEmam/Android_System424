import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../../Models/album.dart';
import '../../Providers/album_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/album_widget_artist_mode.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreateAlbum extends StatefulWidget {
  @override
  _CreateAlbumState createState() => _CreateAlbumState();
}

class _CreateAlbumState extends State<CreateAlbum> {
  static const   routeName='//add_album_screen';
  bool _success= true;
  String _currentTime;
  File imageURI;

  final albumNameController = TextEditingController();
  final albumTypeController =TextEditingController();
  final currentTimeController =TextEditingController();

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image;
    });
  }





  void uploadImage(File file) async
  {
    try {
      FormData formData = new FormData.fromMap(
          {
            //"headers" :
            "files": [
              MultipartFile.fromFile(file.path,),
            ],
            "releaseDate" : _currentTime ,
            "name" : albumNameController.text,
            "type" : albumTypeController.text,
            // "genres": ,
          }
      );
      Response response = await Dio().post('http://www.mocky.io/v2/5e7e7536300000e0134afb12' , data: formData );
      //_showScaffold("This is a SnackBar called from another place.");
    } catch(e)
    {
      _success= false;
      print('error');
    }

  }
  void _createAlbum(BuildContext ctx)
  {
    uploadImage(imageURI);
    setState(() {
      if(_success)
      {
        _currentTime = null;
        Navigator.of(ctx).pop();

      }
    });
  }

  void _updateCurrentTime()
  {
    setState(() {
      _currentTime = DateTime.now().day.toString() +
          '-' + DateTime.now().month.toString() + '-' +
          DateTime.now().year.toString();
    });

  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new album"),
      ),
            body: ListView(
              children: <Widget>[
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
                    controller: albumTypeController,
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
                      margin: EdgeInsets.only(top:deviceSize.width*0.02 , bottom: deviceSize.width*0.02 , left: deviceSize.width*0.05 , right: deviceSize.width*0.05),
                      width: deviceSize.width * 0.515,
                      child: TextFormField(
                        controller: currentTimeController,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    imageURI == null
                        ? Text('No image selected.')
                        : Image.file(imageURI, width: deviceSize.width * 0.4
                        , height: deviceSize.width * 0.4
                        , fit: BoxFit.cover
                    ),

                    Container(
                        margin: EdgeInsets.only(top:deviceSize.width*0.02 , bottom: deviceSize.width*0.02 , left: deviceSize.width*0.05 , right: deviceSize.width*0.05),
                        width: deviceSize.width * 0.515,
                        child: RaisedButton(
                          onPressed: () => getImageFromGallery(),
                          child: Text('open gallery'),
                          textColor: Colors.white,
                          color: Colors.lightGreen,
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        )
                    ),
                  ],
                ),

                RaisedButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('Submit'),
                  onPressed:() => _createAlbum(context),
                ),
              ],
            ),
    );
  }
}
