import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:spotify/Models/http_exception.dart';

class PlayHistoryEndpoints {
  static const me = '/me';
  static const player = '/player';
  static const recentlyPlayed = '/recentlyPlayed';
}

class PlayHistoryAPI {
  final String baseUrl;
  PlayHistoryAPI({
    this.baseUrl,
  });


///A method that fetches recently played playhistory objects.
///It takes an input [token] of type [String].
///It returns [List] of played history objects of type [Map<String,dynamic>].
  Future<List> fetchRecentlyPlayedApi(String token) async {
    final url = baseUrl +
        PlayHistoryEndpoints.me +
        PlayHistoryEndpoints.player +
        PlayHistoryEndpoints.recentlyPlayed;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        print(response);
        Map<String, dynamic> temp = json.decode(response.body);
        final extractedList = temp['data']['results']['items'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
