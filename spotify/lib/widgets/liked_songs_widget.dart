import 'package:flutter/material.dart';
import '../Screens/Library/liked_songs_screen.dart';

class LikedSongWidget extends StatefulWidget {
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
        leading: SizedBox(
          child: Image.asset(
            'assets/images/likedSong.png',
          ),
        ),
        /* FadeInImage(
          //Image.asset('assets/images/likedSong.png'),
          placeholder: AssetImage('assets/images/temp.jpg'),
          image: NetworkImage('assets/images/likedSong.png'),
          fit: BoxFit.fill,
        ),*/
        title: Text(
          "Liked Songs",
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          "song",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
