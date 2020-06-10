import 'package:flutter/material.dart';
import '../Screens/Library/liked_songs_screen.dart';

class LikedSongWidget extends StatefulWidget {
  final int length;
  LikedSongWidget(this.length);
  @override
  _LikedSongWidgetState createState() => _LikedSongWidgetState();
}

class _LikedSongWidgetState extends State<LikedSongWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LikedSongsScreen(),
          ),
        );
      },
      child: ListTile(
        leading: Container(
          height: deviceSize.height * 0.0951,
          width: deviceSize.width * 0.13625,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/likedSong.png'),
                fit: BoxFit.fill),
          ),
        ),
        title: Text(
          "Liked Songs",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        subtitle: Text(
          (widget.length == 1)
              ? widget.length.toString() + " song"
              : widget.length.toString() + " songs",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
