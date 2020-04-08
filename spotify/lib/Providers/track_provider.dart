

//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:spotify/API_Providers/playlistAPI.dart';
import 'dart:io';
import '../Models/track.dart';
//Import Models.
import '../Models/album.dart';



///Class AlbumProvider
class TrackProvider with ChangeNotifier {
  final String baseUrl;

  TrackProvider({this.baseUrl});


  List<Track> topTracks;

  List<Track> get getTopTracks {
    return [...topTracks];
  }


  Future<void> fetchArtistTopTracks(String token, String id) async {
    PlaylistAPI playlistApi = PlaylistAPI(
        baseUrl: baseUrl);
    try {
      final extractedList = await playlistApi.fetchArtistTopTracksApi(
          token, id);
      final List<Track> loadedTracks = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedTracks.add(
            Track.fromJson(
                extractedList[i]));
      }
      topTracks = loadedTracks;
      notifyListeners(
      );
    } catch (error) {
      throw HttpException(
          error.toString(
          ));
    }
  }
}