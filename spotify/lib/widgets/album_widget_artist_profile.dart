import 'package:flutter/material.dart';
class LoadingAlbumsWidget extends StatelessWidget {
  String albumImage = 'https://images.app.goo.gl/geYmfUkbJDgsa2i66';
  String albumName = 'Sahran';
  String albumYear = '2020';
  //LoadingAlbumsWidget(this.albumImage , this.albumName , this.albumYear);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:
      Row(children: <Widget>[
        Container(
          //fit :
          child: Image.network(
            albumImage,
            height: 150,
            width: 200,
            fit: BoxFit.scaleDown,
          ),
        ),
        Column(children: <Widget>[
          Text(albumName),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(albumYear),
              Icon(Icons.shuffle),
            ],
          ),
        ],
        ),

      ],
      ),
      onTap: () {},
    );



  }
}
