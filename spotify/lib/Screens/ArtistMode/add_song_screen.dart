import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import '../../Providers/album_provider.dart';
import 'package:provider/provider.dart';
import '../../Providers/user_provider.dart';


class AddSongScreen extends StatefulWidget {
  //final String id;
  //AddSongScreen(this.id);
  static const  routeName='//add_song_screen';
  @override
  _AddSongScreenState createState() => new _AddSongScreenState();
}

class _AddSongScreenState extends State<AddSongScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _fileName;
  String _path;
  String _extension ;
  bool _loadingPath = false;
  bool _hasValidMime = false;
  FileType _pickingType = FileType.audio;
  TextEditingController _controller = new TextEditingController();
  int _pathLen =1;
  //String id;
  Response response;
  final songNameController = TextEditingController();

  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
  void _openFileExplorer() async {
    if (_pickingType != FileType.custom || _hasValidMime) {
      setState(() => _loadingPath = true);
      try {
          _path = await FilePicker.getFilePath(type: _pickingType, fileExtension: _extension);

      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;
      setState(() {
        _loadingPath = false;
        _fileName = _path != null ? _path.split('/').last  : '...';
      });
    }
  }
  void uploadF(BuildContext context , String path , String userToken , String songName,) async
  {
    bool check =
        await Provider.of<AlbumProvider>(context , listen: false)
        .uploadSong('userToken' ,songName ,path );
    setState(() {
      if(check)
      {
        Navigator.of(context).pop();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    String _user = Provider.of<UserProvider>(context , listen: false).token;
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String , String>;
    //widget.id = routeArgs["id"];
    //String albumId = 'hjdksksl';
    print('indecator');
    //print(widget.id);
    return  Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Add new Song'),
      ),
      body: Container(
        color: Colors.black,
        child:  Center(
            child:  Padding(
              padding:  EdgeInsets.only(left: deviceSize.width*0.01, right: deviceSize.width*0.01),
              child:  SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: deviceSize.width * 0.02,
                          bottom: deviceSize.width * 0.02,
                          left: deviceSize.width * 0.2,
                          right: deviceSize.width * 0.2),
                      width: deviceSize.width * 0.4,
                      child: TextFormField(
                        controller: songNameController,
                        decoration: InputDecoration(
                          labelText: 'choose song name ',
                          filled: true,
                          fillColor: Colors.green[700],
                          labelStyle: TextStyle(
                              color: Colors.white),
                        ),
                        style: TextStyle(
                            color: Colors.black),
                        cursorColor: Theme
                            .of(
                            context)
                            .primaryColor,
                        keyboardType: TextInputType.text,
                      ),
                    ),

                    new Padding(
                      padding: EdgeInsets.only(top: deviceSize.width*0.03, bottom: 0.05),
                      child: new RaisedButton(
                        onPressed: () => _openFileExplorer(),
                        child: new Text("Open file picker" ,
                        style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    new Builder(
                      builder: (BuildContext context) => _loadingPath
                          ? Padding(padding:EdgeInsets.only(bottom: deviceSize.width*0.01), child: CircularProgressIndicator())
                          : _path != null
                          ? new Container(
                        padding:EdgeInsets.only(bottom: deviceSize.width*0.04),
                        height: deviceSize.height * 0.25,
                        child: new Scrollbar(
                            child: new ListView.separated(
                              itemCount: _pathLen ,
                              itemBuilder: (BuildContext context, int index) {
                                final String name = 'File name : '  + _fileName;
                                final path = _path;
                                return ListTile(
                                  title: new Text(
                                    name,
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  subtitle: new Text(path ,
                                    style :TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) => Divider(),
                            )),
                      )
                          :Container(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top : deviceSize.height*0.03),
                      color: Colors.green,
                      child: IconButton(
                        focusColor: Colors.white,
                        onPressed: () => uploadF(context ,_path ,_user ,songNameController.text),
                        icon: Icon(Icons.add,
                        ),
                        iconSize: deviceSize.width*0.1,

                      ),
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}


