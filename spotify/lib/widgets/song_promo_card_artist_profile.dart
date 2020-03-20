import 'package:flutter/material.dart';
class SongPromoCard extends StatelessWidget {
  String image = "https://i.scdn.co/image/c4818b1f9d0c7a793d421b51c63d82c8c768795c";
  String name = 'Sahran';
  String artist = 'AmrDiab123';
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:
      Row(children: <Widget>[
        Container(
          //width: double.infinity,
          padding : EdgeInsets.all(10),
          child: Image.network(
            image,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          ),
        ),
        Column(children: <Widget>[
          Text(name ,
            style: TextStyle(color : Colors.white , fontSize: 18 , ),
          ),
          Text(artist ,
            style: TextStyle(color : Colors.grey , fontSize: 14 , ),
                ),


              ]
          ),
        SizedBox(
          width: 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            IconButton(
            icon : Icon(Icons.favorite,
                color: Colors.grey,),
            ),
            IconButton(
              icon : Icon(Icons.do_not_disturb_off,
                color: Colors.grey,),
            ),
            IconButton(
              icon : Icon(Icons.more_vert,
                color: Colors.grey,),
            ),
          ],
        ),
        ],
        ),


      onTap: () {},
    );



  }
}
