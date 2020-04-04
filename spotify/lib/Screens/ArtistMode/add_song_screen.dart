import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

class addSongScreen extends StatefulWidget {
  static const  routeName='/add_song_screen';
  @override
  _addSongScreenState createState() => new _addSongScreenState();
}

class _addSongScreenState extends State<addSongScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  String _fileName;
  String _path;
  //Map<String, String> _paths;
  String _extension ;
  bool _loadingPath = false;
  //bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;
  TextEditingController _controller = new TextEditingController();
  int _pathLen =1;
  Response response;
  @override
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


  void _uploadFile (filepath) async
  {
    String fileName01 = basename(_path);
    try {
      FormData formData = new FormData.fromMap(
          {
            "files": [
              MultipartFile.fromFile(_path,
              filename: fileName01),
        ],
      }
      );
      print(fileName01);
      response = await Dio().post('http://www.mocky.io/v2/5e7e7536300000e0134afb12' , data: formData );
      print('hi');
      print(formData.files[0]);
      print(response);
      _showScaffold("This is a SnackBar called from another place.");
    } catch(e)
    {
      print('error');
    }

  }
  void uploadF()
  {
    _uploadFile(_path);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: const Text('Add new Song'),
      ),
      body: Container(
        color: Colors.black,
        child: new Center(
            child: new Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: new SingleChildScrollView(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: new DropdownButton(
                        icon: Icon(Icons.arrow_drop_down_circle),
                          hint: new Text('LOAD PATH FROM',
                          style: TextStyle(color: Colors.grey
                          ),
                          ),
                          value: _pickingType,
                          items: <DropdownMenuItem>[
                            new DropdownMenuItem(
                              child: new Text('FROM AUDIO'),
                              value: FileType.audio,
                            ),
                            new DropdownMenuItem(
                              child: new Text('FROM IMAGE'),
                              value: FileType.image,
                            ),
                          ],
                          onChanged: (value) => setState(() {
                            _pickingType = value;
                            if (_pickingType != FileType.custom) {
                              _controller.text = _extension = '';
                            }
                          })),
                    ),
                    new ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 100.0),
                      child: _pickingType == FileType.custom
                          ? new TextFormField(
                        maxLength: 15,
                        autovalidate: true,
                        controller: _controller,
                        decoration: InputDecoration(labelText: 'File extension'),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          RegExp reg = new RegExp(r'[^a-zA-Z0-9]');
                          if (reg.hasMatch(value)) {
                            _hasValidMime = false;
                            return 'Invalid format';
                          }
                          _hasValidMime = true;
                          return null;
                        },
                      )
                          : new Container(),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                      child: new RaisedButton(
                        onPressed: () => _openFileExplorer(),
                        child: new Text("Open file picker" ,
                        style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    new Builder(
                      builder: (BuildContext context) => _loadingPath
                          ? Padding(padding: const EdgeInsets.only(bottom: 10.0), child: const CircularProgressIndicator())
                          : _path != null
                          ? new Container(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: new Scrollbar(
                            child: new ListView.separated(
                              itemCount: _pathLen,
                              itemBuilder: (BuildContext context, int index) {
                                final String name = 'File name : '  + _fileName;
                                final path = _path;

                                return new ListTile(
                                  title: new Text(
                                    name,
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  subtitle: new Text(path ,
                                    style :TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) => new Divider(),
                            )),
                      )
                          : new Container(),
                    ),
                    Container(
                      color: Colors.green,
                      child: IconButton(
                        focusColor: Colors.white,
                        onPressed: uploadF,
                        icon: Icon(Icons.add,
                        ),
                        iconSize: 60,

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


