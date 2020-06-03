import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/track.dart';
import 'package:spotify/Providers/playable_track.dart';
import 'package:spotify/widgets/song_item_in_liked_playlist.dart';
import 'package:spotify/widgets/song_item_in_playlist_list.dart';

class LikedSongsScreen extends StatefulWidget {
  @override
  _LikedSongsScreenState createState() => _LikedSongsScreenState();
}

class _LikedSongsScreenState extends State<LikedSongsScreen> {
  @override
  Widget build(BuildContext context) {
    final playableTrackProvider = Provider.of<PlayableTrackProvider>(context);
    List<Track> likedTracks;
    likedTracks = playableTrackProvider.getLikedTracks;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 70,
            alignment: Alignment.center,
            child: Text(
              "Liked Songs",
              style: TextStyle(fontSize: 22, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          (likedTracks.length == 0)
              ? Container(
                  //height: 70,
                  padding: EdgeInsets.all(50),
                  child: Text(
                    "No Liked Songs yet",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                )
              : Container(
                  child: PreferredSize(
                    child: Transform.translate(
                      offset: Offset(0, 0),
                      child: Container(
                        width: 190.0,
                        child: FloatingActionButton(
                          onPressed: null,
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Text(' SHUFFLE PLAY'),
                        ),
                      ),
                    ),
                    preferredSize: Size.fromHeight(60),
                  ),
                ),
          Container(
            height: 350,
            child: ListView.builder(
              itemCount: likedTracks.length,
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: likedTracks[i],
                child: SongItemInLikedPlaylistList(likedTracks[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
