///Importing dart libraries to use it.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify/Models/http_exception.dart';
import '../API_Providers/artistAPI.dart';

class PlaylistEndPoints {
  static const String playlists = '/playlists';
  static const String tracks = '/tracks';

  static const String popular = '/popular';
  static const String mostRecent = '/top?sort=-createdAt';
  static const String pop = '/pop';
  static const String jazz = '/jazz';
  static const String arabic = '/arabic';
  static const String happy = '/happy';
  static const String artistCreated = '/artist-created-playlists';
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
        headers: {"authorization": "Bearer" + token},
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
        '/most-recent'; //PlaylistEndPoints.mostRecent;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        // Map<String, dynamic> temp = json.decode(response.body);
        // Map<String, dynamic> temp2 = temp['data'];
        final extractedList =
            json.decode(response.body); //temp2['playlist'] as List;
        print(extractedList);
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchPopPlaylistsApi(String token) async {
    final url = baseUrl + PlaylistEndPoints.playlists + PlaylistEndPoints.pop;
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
    final url = baseUrl + PlaylistEndPoints.playlists + PlaylistEndPoints.jazz;
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
    final url =
        baseUrl + PlaylistEndPoints.playlists + PlaylistEndPoints.arabic;
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
    final url = baseUrl + PlaylistEndPoints.playlists + PlaylistEndPoints.happy;
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

  Future<List> fetchPlaylistsTracksApi(String token, String id) async {
    final url = baseUrl + ArtistEndPoints.artists + '/' +
        id + PlaylistEndPoints.artistCreated;
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

  Future<List> fetchArtistPlaylistsApi(String token , String id) async {
    final url = baseUrl + PlaylistEndPoints.playlists + PlaylistEndPoints.happy;
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
