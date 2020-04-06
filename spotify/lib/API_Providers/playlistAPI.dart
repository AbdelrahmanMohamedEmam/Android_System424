///Importing dart libraries to use it.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify/Models/http_exception.dart';

class PlaylistEndPoints {
  static const String playlists = '/playlists';
  static const String popular = '/popular';
  static const String mostRecent = '/most-recent';
  static const String pop = '/pop';
  static const String jazz = '/jazz';
  static const String arabic = '/arabic';
  static const String happy = '/happy';
}

class PlaylistAPI {
  final String baseUrl;
  PlaylistAPI({
    this.baseUrl,
  });

  Future<List> fetchPopularPlaylistsApi(String token) async {
    final url = baseUrl +
        PlaylistEndPoints.playlists +
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
    final url = baseUrl +
        PlaylistEndPoints.playlists +
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
    final url = baseUrl +
        PlaylistEndPoints.playlists +
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
    final url = baseUrl +
        PlaylistEndPoints.playlists +
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

  Future<List> fetchArabicPlaylistsApi(String token) async {
    final url = baseUrl +
        PlaylistEndPoints.playlists +
        PlaylistEndPoints.arabic; //base url to be added
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

  Future<List> fetchHappyPlaylistsApi(String token) async {
    final url = baseUrl +
        PlaylistEndPoints.playlists +
        PlaylistEndPoints.happy; //base url to be added
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
