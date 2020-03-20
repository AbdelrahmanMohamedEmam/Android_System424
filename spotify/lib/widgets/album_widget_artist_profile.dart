import 'package:flutter/material.dart';
class LoadingAlbumsWidget extends StatelessWidget {
  String albumImage = "https://i.scdn.co/image/c4818b1f9d0c7a793d421b51c63d82c8c768795c";
  String albumName = 'Sahran';
  String albumYear = '2020';
  //LoadingAlbumsWidget(this.albumImage , this.albumName , this.albumYear);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:
      Row(children: <Widget>[
        Container(
          padding : EdgeInsets.all(10),
          child: Image.network(
            albumImage,
            height: 70,
            width: 70,
            fit: BoxFit.fill,
          ),
        ),
        Column(children: <Widget>[
          Text(albumName ,
            style: TextStyle(color : Colors.white , fontSize: 18 , ),
          ),

          Container(
            padding : EdgeInsets.only(top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.shuffle , color: Colors.grey, ),
                Text(albumYear ,
                  style: TextStyle(color : Colors.grey , fontSize: 14 , ),
                ),

              ],
            ),
          ),
        ],
        ),

      ],
      ),
      onTap: () {},
    );



  }
}
