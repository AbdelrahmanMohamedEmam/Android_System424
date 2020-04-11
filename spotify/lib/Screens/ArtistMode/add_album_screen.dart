import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_test/flutter_test.dart';
import '../../Providers/album_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';
//import 'package:image_picker/image_picker.dart';
import '../../Providers/user_provider.dart';


class CreateAlbum extends StatefulWidget {
  @override
  _CreateAlbumState createState() => _CreateAlbumState();
}

class _CreateAlbumState extends State<CreateAlbum> {

  ///route name to get to the screen from navigator.
  static const   routeName='//add_album_screen';

  ///String to store today's date (required to add new album release date).
  String _currentTime = 'click on timer to get today date';

  ///indicator to the file which the user pick image to.
  File imageURI;

  ///controller for album name text field.
  final albumNameController = TextEditingController();

  ///controller for album type text field.
  final albumTypeController =TextEditingController();

  ///controller for current time text field.
  final currentTimeController =TextEditingController();

  ///selected value of the album type drop down menu.
  String dropdownValue1 = 'Single';

  ///selected value of the genres drop down menu.
  String dropdownValue2 = 'rock';

///method to pick image from mobile gallery.
  /*Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image;
    });
  }*/

///method used to create new album by sending its data to the server.
  /*void _createAlbum(BuildContext ctx , String _userToken ) async
  {
    bool check =
    await Provider.of<AlbumProvider>(context , listen: false)
        .uploadImage(imageURI ,_userToken ,albumNameController.text ,dropdownValue1 , _currentTime , dropdownValue2 );
    setState(() {
      if(check)
      {
        _currentTime = '0';
        Navigator.of(ctx).pop();
      }
    });
  }*/

///method that updates the date to the date of now.
  void _updateCurrentTime() {
    setState(
            () {
          _currentTime = DateTime
              .now(
          )
              .day
              .toString(
          ) +
              '-' + DateTime
              .now(
          )
              .month
              .toString(
          ) + '-' +
              DateTime
                  .now(
              )
                  .year
                  .toString(
              );
        });
  }


  @override
  Widget build(BuildContext context) {
    ///get device size for responsiveness issues.
    final deviceSize = MediaQuery.of(context).size;
    String _user = Provider.of<UserProvider>(context , listen: false).token;
    print(_user);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[700] ,
          title: Text(
              "Create new album"),
        ),
        body: Container(
          color: Colors.black,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(deviceSize.height*0.03),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: deviceSize.width * 0.02,
                    bottom: deviceSize.width * 0.02,
                    left: deviceSize.width * 0.2,
                    right: deviceSize.width * 0.2),
                width: deviceSize.width * 0.4,
                child: TextFormField(
                  controller: albumNameController,
                  decoration: InputDecoration(
                    labelText: 'Album name ',
                    filled: true,
                    fillColor: Colors.green[700],
                    labelStyle: TextStyle(
                        color: Colors.white ,
                    fontSize: 15),
                  ),
                  style: TextStyle(
                      color: Colors.white),
                  cursorColor: Theme
                      .of(
                      context)
                      .primaryColor,
                  keyboardType: TextInputType.text,
                ),
              ),
                Container(
                  margin: EdgeInsets.only(
                      top: deviceSize.width * 0.02,
                      bottom: deviceSize.width * 0.02,
                      left: deviceSize.width * 0.2,
                      right: deviceSize.width * 0.2),
                  width: deviceSize.width * 0.4,
                  color: Colors.green[700],
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                    value: dropdownValue1,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 12,
                    style: TextStyle(color: Colors.black , fontSize: 12 , fontWeight: FontWeight.bold),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue1 = newValue;
                      });
                    },
                    items: <String>['Single', 'Remix', 'Compilation', 'Split' , 'Cover' , 'Live' , 'Sound Track' , 'Studio']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          margin: EdgeInsets.only(left: deviceSize.width*0.01),
                          child: Text(value , style:
                            TextStyle(color: Colors.white
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                ),
                  ),
                ),
              Container(
                margin: EdgeInsets.only(
                    top: deviceSize.width * 0.02,
                    bottom: deviceSize.width * 0.02,
                    left: deviceSize.width * 0.2,
                    right: deviceSize.width * 0.2),
                width: deviceSize.width * 0.4,
                color: Colors.green[700],
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue2,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 12,
                    style: TextStyle(color: Colors.black , fontSize: 12 , fontWeight: FontWeight.bold),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue2 = newValue;
                      });
                    },
                    items: <String>['pop', 'rock', 'jazz', 'house' , 'classic' , 'sha3by']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          margin: EdgeInsets.only(left: deviceSize.width*0.01),
                          child: Text(value , style:
                          TextStyle(color: Colors.white
                          ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.green[700],
                    tooltip: 'Get current time',
                    child: Icon(
                        Icons.timer),
                    onPressed: _updateCurrentTime,

                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: deviceSize.width * 0.02,
                          bottom: deviceSize.width * 0.02,
                          left: deviceSize.width * 0.06,
                          right: deviceSize.width * 0.2),
                    width: deviceSize.width * 0.6,
                    height: deviceSize.width * 0.12,
                    color: Colors.green[700],
                    child: Card(
                      color: Colors.green[700],
                      child: Text(_currentTime , style:
                        TextStyle(
                      color: Colors.white,
                      fontSize : 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  imageURI == null
                      ? Text(
                      'No image selected.',
                  style: TextStyle(
                    color: Colors.redAccent
                  ),)
                      : Image.file(
                      imageURI, width: deviceSize.width * 0.4
                      , height: deviceSize.width * 0.4
                      , fit: BoxFit.cover
                  ),

                  Container(
                      margin: EdgeInsets.only(
                          top: deviceSize.width * 0.02,
                          bottom: deviceSize.width * 0.02,
                          left: deviceSize.width * 0.2,
                          right: deviceSize.width * 0.2),
                      width: deviceSize.width * 0.7,
                      height: deviceSize.width * 0.12,
                      child: RaisedButton(
                        //onPressed: () =>getImageFromGallery(),
                        child: Text(
                            'Open Gallery'),
                        textColor: Colors.white,
                        color: Colors.green[700],
                        padding: EdgeInsets.fromLTRB(
                            12, 12, 12, 12),
                      )
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(deviceSize.height*0.01),
              ),
        Container(
          margin: EdgeInsets.only(
              right: deviceSize.width * 0.25,
              left: deviceSize.width * 0.25),
          height: deviceSize.height * 0.07,
          width: deviceSize.width * 0.1,
          child: FloatingActionButton(
           // onPressed: () => _createAlbum(context, _user),
            backgroundColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
              SizedBox(
                height: deviceSize.height * 0.1713,
              )
        ],
              ),
          ),
        );
    }
  }
