//Importing libraries from external packages.
import 'package:flutter/foundation.dart';

//Import Providers and models.
import 'package:spotify/API_Providers/playHistoryAPI.dart';
import 'package:spotify/Models/http_exception.dart';

//Import Models.
import '../Models/play_history.dart';

///Class PlayHistory Provider
class PlayHistoryProvider with ChangeNotifier {
  ///The baseUrl for this provider.
  final String baseUrl;

  ///Constructor with named argument assignment.
  PlayHistoryProvider({this.baseUrl});

  ///List of playhistory objects for recentlyplayed.
  List<PlayHistory> _recentlyPlayed = [];

  ///A Method getter to retrun recently played list.
  List<PlayHistory> get getRecentlyPlayed {
    return [..._recentlyPlayed];
  }

  ///A Method getter to retrun recently played artists list.
  List<PlayHistory> get getRecentlyPlayedArtists {
    List<PlayHistory> temp = [];
    for (int i = 0; i < _recentlyPlayed.length; i++) {
      if (_recentlyPlayed[i].context.type == "artist") {
        temp.add(_recentlyPlayed[i]);
      }
    }
    return [...temp];
  }

  ///A method to empty the list.
  void emptyList() {
    _recentlyPlayed = [];
  }

  ///A method that fetches recently played List and set them in recently played list.
  ///It takes a [String] token for verification.
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
