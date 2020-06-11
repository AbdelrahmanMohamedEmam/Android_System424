//import 'dart:math';

///Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:spotify/API_Providers/trackAPI.dart';
import 'package:spotify/Models/album.dart';
import 'package:spotify/Models/artist.dart';
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
  List<Track> likedTracks = [];

  ///Shuffled Tracks Array
  List<Track> tracksToBePlayed = [];

  ///Shuffled Tracks ids Array
  List<String> shuffledTracksIDs = [];

  ///Index of track to be played
  int indexOfTrack;

  ///Track containing the ad
  Track advertisement;

  void setTracksToBePlayed(List<Track> tracksToAdd) {
    tracksToBePlayed = tracksToAdd;
    indexOfTrack = 0;
  }

  void playAd() {
    currentSong = advertisement;
    _waitingSong = true;
    notifyListeners();
  }

  ///Setting the song to requested to be played.
  void setCurrentSong(Track song, bool isPremium, String token) {
    if (isPremium) {
      currentSong = song;
      _waitingSong = true;
      notifyListeners();
    } else {
      final id = shuffledTracksIDs[indexOfTrack];
      final index = tracksToBePlayed.indexWhere((track) => track.id == id);
      print('INDEX' + index.toString());
      print(tracksToBePlayed[index].name);
      currentSong = tracksToBePlayed[index];
      _waitingSong = true;
      indexOfTrack++;
      if (indexOfTrack >= tracksToBePlayed.length) {
        indexOfTrack = 0;
      }
      notifyListeners();
    }
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

  ///A method(getter) that returns a list of tracks (liked tracks).
  List<Track> get getLikedTracks {
    return likedTracks;
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
  bool isTrackLiked(String id) {
    if (likedTracks.isEmpty) {
      return false;
    }
    if (likedTracks.indexWhere((track) => track.id == id) != -1) {
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

      likedTracks = parceTrackPlaylists(extractedList);
    } catch (error) {
      print(error.toString());
    }
  }

  Future<bool> likeTrack(String token, Track song) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.likeTrack(token, song.id);
      likedTracks.add(song);
      notifyListeners();
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> unlikeTrack(String token, String trackId) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.unlikeTrack(token, trackId);
      if (true) {
        int index = likedTracks.indexWhere((track) => track.id == trackId);
        if (index != -1) {
          likedTracks.removeAt(index);
        }
        notifyListeners();
        return response;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<bool> nextTrack(String token) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.nextTrack(token);
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> playNextTrack(String token) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.nextTrack(token);
      if (response == true) {
        final id = shuffledTracksIDs[indexOfTrack];
        final index = tracksToBePlayed.indexWhere((track) => track.id == id);
        final checkAd = await checkIfAd(tracksToBePlayed[index], token);
        if (!checkAd) {
          print(tracksToBePlayed[index].id);
          currentSong = tracksToBePlayed[index];
          _waitingSong = true;
          indexOfTrack++;
          if (indexOfTrack >= tracksToBePlayed.length) {
            indexOfTrack = 0;
          }
        } else {
          await adTrack(token);
          print(advertisement.name);
          print(advertisement.href);
          print(advertisement.album);
          print(advertisement.name);

          currentSong = advertisement;
          _waitingSong = true;
        }
        notifyListeners();
        return true;
      }
      return false;
      //return response;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> playPreviousTrack(String token) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.previousTrack(token);
      if (response == true) {
        indexOfTrack = indexOfTrack - 2;
        print('indexx' + indexOfTrack.toString());
        if (indexOfTrack < 0) {
          indexOfTrack = tracksToBePlayed.length - 1;
        }
        final id = shuffledTracksIDs[indexOfTrack];
        final index = tracksToBePlayed.indexWhere((track) => track.id == id);
        print(tracksToBePlayed[index].id);
        currentSong = tracksToBePlayed[index];
        _waitingSong = true;
        indexOfTrack++;
        notifyListeners();
        return true;
      }
      return false;
      //return response;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> previousTrack(String token) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.previousTrack(token);
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> finishedTrack(String token) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      if (!currentSong.isAd) {
        final response = await trackAPI.finishedTrack(token);
      }
      final id = shuffledTracksIDs[indexOfTrack];
      final index = tracksToBePlayed.indexWhere((track) => track.id == id);
      print('INDEX' + index.toString());
      final checkAd = await checkIfAd(tracksToBePlayed[index], token);
      if (!checkAd) {
        print(tracksToBePlayed[index].id);
        currentSong = tracksToBePlayed[index];
        _waitingSong = true;
        indexOfTrack++;
        if (indexOfTrack >= tracksToBePlayed.length) {
          indexOfTrack = 0;
        }
      } else {
        await adTrack(token);
        currentSong = advertisement;
        _waitingSong = true;
      }
      notifyListeners();
      return true;
    } catch (error) {
      throw error;
    }
  }

  Future<void> shuffledTrackList(String token, String id, String type) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final extractedList = await trackAPI.shuffledTrackList(token, id, type);
      shuffledTracksIDs.clear();
      for (int i = 0; i < extractedList.length; i++) {
        shuffledTracksIDs.add(extractedList[i].toString());
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> adTrack(String token) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.adTrack(token);
      print(response['_id']);
      print(response['href']);
      advertisement = new Track(
          isAd: true,
          id: response['_id'],
          href: response['href'],
          artists: [
            new Artist(
              id: '1',
              name: 'MOSTASHFA',
            )
          ],
          name: '57375',
          trackNumber: 0,
          album: new Album(
            name: 'RAMADAN ADS',
            artists: [
              new Artist(
                id: '5',
                name: 'MOSTASHFA',
              )
            ],
            id: '1',
            href:
                'https://totallynotspotify.codes/api/tracks/5ec459bbe84eaf30fccf46db',
            image:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrnc7bofPWABq1j-PjN3XUPMc2_n9cFD6ntfKwnNAPLQ3gAOK3&usqp=CAU',
            images: [
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrnc7bofPWABq1j-PjN3XUPMc2_n9cFD6ntfKwnNAPLQ3gAOK3&usqp=CAU'
            ],
          )
      );
    } catch (error) {
      print(error.toString());
    }
  }

  Future<bool> checkIfAd(Track song, String token) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final response = await trackAPI.checkIfAd(song, token);
      if (response == true) {
        await trackAPI.adTrack(token);
        return true;
      }
      return false;
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }
}
