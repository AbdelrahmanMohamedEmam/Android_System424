import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/artist.dart';
import 'package:spotify/Providers/artist_provider.dart';

class ArtistBackground extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final artistsInformation = Provider.of<Artist>(context);
    return
      Stack(
        children : <Widget> [
          Container(
            height: deviceSize.height*0.5,
            width: double.infinity,
            padding: EdgeInsets.all(deviceSize.width*0.01),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/temp.jpg'),
              image: NetworkImage(
                artistsInformation.images[0].url,
              ),
            ),
          ),
          Positioned(
            top: deviceSize.height*0.26,
            bottom: deviceSize.width*0.2,
            left: deviceSize.width*0.17,
            right: deviceSize.height*0.17,
            child: Text(artistsInformation.name,
              textAlign: TextAlign.center,
              style : TextStyle(color: Colors.white ,
                fontWeight: FontWeight.bold ,
                fontSize: 50,
              ),
            ),
          ),
        ],

      );
  }
}