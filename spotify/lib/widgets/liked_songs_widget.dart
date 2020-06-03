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
          height: 65,
          width: 56,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/likedSong.png'),
                fit: BoxFit.fill),
          ),
        ),
        //  SizedBox(

        //   child: Image.asset(
        //     'assets/images/likedSong.png',
        //   ),
        // ),
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
