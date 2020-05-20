///Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:spotify/API_Providers/trackAPI.dart';
import 'package:spotify/utilities.dart';

///Import Models.
import '../Models/track.dart';

///Class PlayableTrackProvider
class PlayableTrackProvider with ChangeNotifier {
  final String baseUrl;
  PlayableTrackProvider({this.baseUrl});

  ///Song being played currently.
  Track currentSong;

  ///Indicates if a song is requested to be played.
  bool _waitingSong = false;

  ///Liked Tracks Array
  List<Track> likedTracks=[];

  ///Setting the song to requested to be played.
  void setCurrentSong(Track song) {
    currentSong = song;
    _waitingSong = true;
    notifyListeners();
  }

  ///Getter for the song currently being played.
  Track getCurrentSong() {
    Track songToBeSent = currentSong;
    _waitingSong = false;
    return songToBeSent;
  }

  ///True if there is a song requested to be played.
  bool getWaitingStatus() {
    return _waitingSong;
  }

  ///Sends a http request to add a track to recently played.
  ///Context Uri, Track Uri and Context type must be provided.
  ///Token must be provided for authentication.
  ///An object from the API provider [TrackAPI] to send requests is created.
  Future<void> addToRecentlyPlayed(String contextUri, String trackUri,
      String contextType, String token) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final responseData = await trackAPI.addToRecentlyPlayed(
          contextUri, trackUri, contextType, token);
      if (responseData == true) {
        return;
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  ///Checks if track with a certain id is liked
  bool isTrackLiked(String id){
    if (likedTracks.isEmpty)
      {
        return false;
      }
    if(likedTracks.indexWhere((track) => track.id == id)!=-1)
      {
        return true;
      }
    return false;
  }


  ///Sends a http request to fetch liked tracks.
  ///Context Uri, Track Uri and Context type must be provided.
  ///Token must be provided for authentication.
  ///An object from the API provider [TrackAPI] to send requests is created.
  Future<void> fetchUserLikedTracks(String token, int limit) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final extractedList = await trackAPI.fetchUserLikedTracks(token, limit);

        likedTracks=parceTrackPlaylists(extractedList);



    }catch(error){
        print(error.toString());
    }
  }

  Future<bool> likeTrack(String token, Track song) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.likeTrack(token, song.id);
      likedTracks.add(song);
      return response;
    }catch (error){
      throw error;
    }
  }

  Future<bool> unlikeTrack(String token, String trackId) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.unlikeTrack(token, trackId);
      if(true) {

        int index=likedTracks.indexWhere((track) => track.id == trackId);
        if(index!=-1)
          {
            likedTracks.removeAt(index);
          }
        return response;
      }
    }catch (error){
      throw error;
    }
  }

  Future<bool> nextTrack(String token) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.nextTrack(token);
      return response;
    }catch (error){
      throw error;
    }
  }

  Future<bool> previousTrack(String token) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.previousTrack(token);
      return response;
    }catch (error){
      throw error;
    }
  }

  Future<bool> finishedTrack(String token) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.finishedTrack(token);
      return response;
    }catch (error){
      throw error;
    }
  }


}
