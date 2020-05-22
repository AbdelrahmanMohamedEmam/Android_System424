//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:spotify/API_Providers/playlistAPI.dart';
import 'package:spotify/API_Providers/trackAPI.dart';
import 'dart:io';
import '../Models/track.dart';

///Class TrackProvider
///Class [TrackProvider] which is used to provide track info.
class TrackProvider with ChangeNotifier {
  /// Indicator tom set the [baseUrl] to know which source will data be loaded from.
  /// mock source or the original database [required] parameter
  final String baseUrl;

  ///Constructor to set then baseUrl
  TrackProvider({this.baseUrl});

  ///List of top tracks object which is related to certain artist.
  List<Track> topTracks;

  ///List of top tracks object which is related to certain artist.
  List<Track> searchedTracks;

  ///getter for [topTracks] member of track provider.
  List<Track> get getTopTracks {
    return [...topTracks];
  }

  ///getter for [searchedTracks] member of track provider.
  List<Track> get getSearchedTracks {
    return [...searchedTracks];
  }

  void emptySearchList() {
    searchedTracks = [];
  }

  ///A method that fetches list of top tracks related to certain artist.
  Future<void> fetchArtistTopTracks(String token, String id) async {
    PlaylistAPI playlistApi = PlaylistAPI(baseUrl: baseUrl);
    try {
      final extractedList =
          await playlistApi.fetchArtistTopTracksApi(token, id);
      final List<Track> loadedTracks = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedTracks.add(Track.fromJson(extractedList[i]));
      }
      topTracks = loadedTracks;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches list of searched tracks related to certain artist.
  Future<void> fetchsearchedTracks(String token, String searchedText) async {
    TrackAPI trackAPI = TrackAPI(baseUrl: baseUrl);
    try {
      final extractedList =
          await trackAPI.fetchSearchedTracksAPI(token, searchedText);
      final List<Track> loadedTracks = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedTracks.add(Track.fromJson(extractedList[i]));
      }
      searchedTracks = loadedTracks;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
