///Importing dart libraries to use it.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify/Models/http_exception.dart';

///Importing models.
import '../Models/playlist.dart';

class PlaylistEndPoints {
  static const String popular = '/popular';
  static const String mostRecent = '/most-recent';
  static const String pop = '/pop';
  static const String jazz='/jazz';
}

class PlaylistAPI {
  final String baseUrl;
  PlaylistAPI({
    this.baseUrl,
  });

  Future<List> fetchPopularPlaylistsApi(String token) async {
    final url = 'http://spotify.mocklab.io' +
        PlaylistEndPoints.popular; //base url to be added
    try {
      final response = await http.get(
        url,
        headers: {'authorization': token},
      );
      if (response.statusCode == 200) {
        final extractedList = json.decode(response.body) as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchMostRecentPlaylistsApi(String token) async {
    final url = 'http://spotify.mocklab.io' +
        PlaylistEndPoints.mostRecent; //base url to be added
    try {
      final response = await http.get(
        url,
        headers: {'authorization': token},
      );
      if (response.statusCode == 200) {
        final extractedList = json.decode(response.body) as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchPopPlaylistsApi(String token) async {
    final url = 'http://spotify.mocklab.io' +
        PlaylistEndPoints.pop; //base url to be added
    try {
      final response = await http.get(
        url,
        headers: {'authorization': token},
      );
      if (response.statusCode == 200) {
        final extractedList = json.decode(response.body) as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

    Future<List> fetchJazzPlaylistsApi(String token) async {
    final url = 'http://spotify.mocklab.io' +
        PlaylistEndPoints.jazz; //base url to be added
    try {
      final response = await http.get(
        url,
        headers: {'authorization': token},
      );
      if (response.statusCode == 200) {
        final extractedList = json.decode(response.body) as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
