//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/API_Providers/playHistoryAPI.dart';
import 'package:spotify/Models/http_exception.dart';

//Import core libraries.
import 'dart:convert';

//Import Models.
import '../Models/play_history.dart';

class PlayHistoryProvider with ChangeNotifier {
  final String baseUrl;
  PlayHistoryProvider({this.baseUrl});
  List<PlayHistory> _recentlyPlayed = [];

  List<PlayHistory> get getRecentlyPlayed {
    return [..._recentlyPlayed];
  }

  List<PlayHistory> get getRecentlyPlayedArtists {
    List<PlayHistory> temp = [];
    for (int i = 0; i < _recentlyPlayed.length; i++) {
      if (_recentlyPlayed[i].context.type == "artist") {
        temp.add(_recentlyPlayed[i]);
      }
    }
    return [...temp];
  }

  void emptyList() {
    _recentlyPlayed = [];
  }

  Future<void> fetchRecentlyPlayed(String token) async {
    PlayHistoryAPI playHistoryAPI = PlayHistoryAPI(baseUrl: baseUrl);
    try {
      final extractedList = await playHistoryAPI.fetchRecentlyPlayedApi(token);
      final List<PlayHistory> loadedPlaylists = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedPlaylists.add(PlayHistory.fromJson(extractedList[i]));
      }
      _recentlyPlayed = loadedPlaylists;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
