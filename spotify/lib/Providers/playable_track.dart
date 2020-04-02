//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//Import core libraries.
import 'dart:convert';

//Import Models.
import '../Models/track.dart';

///Class PlayableTrackProvider
class PlayableTrackProvider with ChangeNotifier {

  ///Song being played currently.
  Track currentSong;

  ///Indicates if a song is requested to be played.
  bool _waitingSong=false;


  ///Setting the song to requested to be played.
  void setCurrentSong(Track song){
    currentSong=song;
    _waitingSong=true;
    notifyListeners();
  }

  ///Getter for the song currently being played.
  Track getCurrentSong(){
    Track songToBeSent=currentSong;
    _waitingSong=false;
    return songToBeSent;
  }

  ///True if there is a song requested to be played.
  bool getWaitingStatus(){
    return _waitingSong;
  }


}
