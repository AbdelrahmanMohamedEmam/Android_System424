import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/track.dart';
import 'package:spotify/Providers/playable_track.dart';
import 'package:spotify/widgets/song_item_in_liked_playlist.dart';

class LikedSongsScreen extends StatefulWidget {
  @override
  _LikedSongsScreenState createState() => _LikedSongsScreenState();
}

class _LikedSongsScreenState extends State<LikedSongsScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
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
            height: deviceSize.height * 0.04,
            alignment: Alignment.center,
            child: Text(
              "Liked Songs",
              style: TextStyle(fontSize: 22, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          (likedTracks.length == 0)
              ? Container(
                  padding: EdgeInsets.only(
                      top: deviceSize.height * 0.073206,
                      bottom: deviceSize.height * 0.073206,
                      left: deviceSize.width * 0.12165,
                      right: deviceSize.width * 0.12165),
                  child: Text(
                    "No Liked Songs yet",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                )
              : Container(
                  height: deviceSize.height * 0.75,
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
