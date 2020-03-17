import 'package:spotify/Models/playlist.dart';
import '../Models/playlist.dart';
import '../Models/user.dart';

class Artist {
  final List albums;  //must be List<albums>
  final List <Playlist> playlists;
  final List songs;
  final List <User> suggesstedArtists;
  final String aboutInfo;
  final User userInfo;

  //*THESE ATTRIBUTES WILL BE LOADED FROM USER PROVIDER*//
  //final String id;
  //final String imageUrl;
  //final String username;
  //final bool isArtist;
  // final int noOfFollowers;


  Artist({
    this.albums ,
    this.playlists ,
    this.songs ,
    this.suggesstedArtists ,
    this.aboutInfo,
    this.userInfo,
  });
}
