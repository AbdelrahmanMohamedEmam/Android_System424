import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotify/Providers/artist_provider.dart';
import 'package:provider/provider.dart';
import '../../Models/artist.dart';

class InfoScreen extends StatefulWidget {

  final imageUrl;
  final bio;
  String name;
  InfoScreen({this.imageUrl , this.bio ,this.name});
  ///route name to get to the screen from navigator.
  static const routeName = '//info_screen';
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  ///variable of type artist to accses the info fetched from artist provider.

  @override
  Widget build(BuildContext context) {
    ///getting device size due to responsiveness issues.
    final deviceSize = MediaQuery.of(context).size;

    ///artist provider object to get the ArtistInfo data from the artist object.
    final artistProvider = Provider.of<ArtistProvider>(context, listen: false);

    ///calling getter function.


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: deviceSize.height * 0.1),
            height: deviceSize.height * 0.4,
            width: double.infinity,
            child: Image.network(
                widget.imageUrl
              //"https://i.scdn.co/image/c4818b1f9d0c7a793d421b51c63d82c8c768795c",
            ),
          ),
          Text(
            "Biography : ",
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.only(
                top: deviceSize.height * 0.05,
                bottom: deviceSize.height * 0.05,
                left: deviceSize.height * 0.01,
                right: deviceSize.height * 0.01),
            child: Text(
              widget.bio,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
