import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about_screen';
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String , String>;
    final artName = routeArgs["name"];
    final artImage = routeArgs["image"];
    final artBio = routeArgs["bio"];
    //final artPopularity = routeArgs["popularity"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          artName ,
          style: TextStyle(fontSize: 18 ,
          fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        //width: double.infinity,
        //height: double.infinity,
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Image.network(artImage)
            ),
            Container(
                height: 100,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Text('popularity' ,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ),
            ),
            Container(
                height: 100,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Text(artBio,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,)
            ),
            ),
          ],
        ),
      ),
    );
  }
}
