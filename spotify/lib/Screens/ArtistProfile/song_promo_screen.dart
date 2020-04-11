/*import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/song_promo_card_artist_profile.dart';


class SongPromoScreen extends StatelessWidget {
  static const routeName = '/promo_screen';
  String artist = 'AmrDiab123';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(artist,
        textAlign: TextAlign.center,
        style : TextStyle(
        fontSize: 14,
        color: Colors.white,
        ),
      ),
      ),
      body: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(5),
        child: ListView(children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Text(artist,
              textAlign: TextAlign.center,
              style : TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only( bottom: 5),
            child:  Text('preview songs and tell us what you like.',
            textAlign: TextAlign.center,
            style : TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Text('Featuring',
              textAlign: TextAlign.start,
              style : TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          SongPromoCard(),          //to be changed with list view
          SongPromoCard(),
          SongPromoCard(),
          SongPromoCard(),
          SongPromoCard(),
          SongPromoCard(),

        ],

        )


      ),
    );
  }
}
*/
