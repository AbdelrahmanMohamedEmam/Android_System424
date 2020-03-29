import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  final imageUrl =
      'https://i.pinimg.com/originals/50/f8/1a/50f81a9ed01cdbca80ff98bd5a640c50.jpg';
  PaletteGenerator paletteGenerator;
  Color backColorDark;
  Color backColorLight;
  Color backColor;

  @override
  void initState() {
    _generatePalette();
    super.initState();
  }

  Future<void> _generatePalette() async {
    PaletteGenerator _paletteGenerator =
        await PaletteGenerator.fromImageProvider(NetworkImage(imageUrl),
            size: Size(110, 150), maximumColorCount: 20);
    backColorDark = _paletteGenerator.darkMutedColor.color.withOpacity(0.3);
    backColorLight = _paletteGenerator.lightMutedColor.color;
    backColor = _paletteGenerator.mutedColor.color;
    setState(() {
      paletteGenerator = _paletteGenerator;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black87,
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: deviceSize.height * 0.1,
                ),
                Container(
                  child: Image.network(
                    imageUrl,
                    height: deviceSize.height * 0.35,
                  ),
                ),
                SizedBox(height: deviceSize.height*0.05,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: deviceSize.width*0.05, bottom: deviceSize.height*0.01),
                          child:Text(
                          'Thinking out loud',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: deviceSize.width * 0.04),
                        ),
                        ),
                        Row(
                          children: <Widget>[
                           Container(
                             margin: EdgeInsets.only(left: deviceSize.width*0.05),
                             child: CircleAvatar(
                              backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTaz8aKS6WJlyth9YfaN5Q9ARknk4j0L1ceShwp6K-vLssSyom5'),
                              radius: deviceSize.height * 0.02,
                            ),),
                              Container(
                                margin: EdgeInsets.only(left: deviceSize.width*0.01),
                                child:Text(
                              'Maroon 5',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: deviceSize.width * 0.032),
                            ),)
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: deviceSize.width*0.05,top: deviceSize.height*0.01),
                          child:Text(
                          'Single 2015',
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: deviceSize.width * 0.028),
                        ),
                        ),
                        Row(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: deviceSize.width*0.02,bottom: deviceSize.height*0.08),
                            child:IconButton(icon: Icon(Icons.favorite_border, color: Colors.white70,)),),
                         Container(
                           margin: EdgeInsets.only(bottom: deviceSize.height*0.08),
                           child: IconButton(icon: Icon(Icons.more_horiz, color:Colors.white70,)),),
                          SizedBox(width: deviceSize.width*0.45,),
                          Container(
                            height: deviceSize.height*0.1,
                              child:IconButton(icon: Icon(Icons.play_circle_filled, color: Colors.green,size: deviceSize.height*0.1,),),)
                        ],)
                      ],
                    ),
                  ],
                ),
            ),
    );
  }
}
