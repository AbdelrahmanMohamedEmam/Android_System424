///Importing dart libraries to use it.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify/Models/http_exception.dart';

class PlaylistEndPoints {
  static const String playlists = '/playlists';
  static const String tracks = '/tracks';

  static const String popular = '/top?sort=-popularity';
  static const String mostRecent = '/top?sort=-createdAt';
  static const String pop = '/pop';
  static const String jazz = '/jazz';
  static const String arabic = '/arabic';
  static const String happy = '/happy';
  static const browse = '/browse';
  static const categories = '/categories';
}

class PlaylistAPI {
  final String baseUrl;
  PlaylistAPI({
    this.baseUrl,
  });

  Future<List> fetchPopularPlaylistsApi(String token) async {
    final url =
        baseUrl + PlaylistEndPoints.playlists + PlaylistEndPoints.popular;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      print("hello");
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['playlist'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchMostRecentPlaylistsApi(String token) async {
    final url =
        baseUrl + PlaylistEndPoints.playlists + PlaylistEndPoints.mostRecent;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['playlist'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchPopPlaylistsApi(String token, String id) async {
    final url = baseUrl +
        PlaylistEndPoints.browse +
        PlaylistEndPoints.categories +
        '/' +
        id +
        PlaylistEndPoints.playlists;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['playlists'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchJazzPlaylistsApi(String token, String id) async {
    final url = baseUrl +
        PlaylistEndPoints.browse +
        PlaylistEndPoints.categories +
        '/' +
        id +
        PlaylistEndPoints.playlists;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['playlists'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchArabicPlaylistsApi(String token, String id) async {
    final url = baseUrl +
        PlaylistEndPoints.browse +
        PlaylistEndPoints.categories +
        '/' +
        id +
        PlaylistEndPoints.playlists;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['playlists'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchHappyPlaylistsApi(String token, String id) async {
    final url = baseUrl +
        PlaylistEndPoints.browse +
        PlaylistEndPoints.categories +
        '/' +
        id +
        PlaylistEndPoints.playlists;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['playlists'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchPlaylistsTracksApi(String token, String id) async {
    final url = baseUrl +
        PlaylistEndPoints.playlists +
        '/' +
        id +
        PlaylistEndPoints.tracks;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        print(response.body);
        Map<String,dynamic> temp=json.decode(response.body);
        Map<String,dynamic>temp2=temp['data'];
        final extractedList = temp2['tracksArray'] as List;

        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
