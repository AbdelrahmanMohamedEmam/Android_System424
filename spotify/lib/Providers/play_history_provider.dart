//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//Import core libraries.
import 'dart:convert';

//Import Models.
import '../Models/play_history.dart';

class PlayHistoryProvider with ChangeNotifier {
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

  Future<void> fetchRecentlyPlayed() async {
    const url = 'http://www.mocky.io/v2/5e87e29131000059003f4771';
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<PlayHistory> loadedPlaylists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedPlaylists.add(PlayHistory.fromJson(extractedList[i]));
    }
    _recentlyPlayed = loadedPlaylists;
    notifyListeners();
  }
}
