///Importing dart libraries to use it.
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/Models/http_exception.dart';
import 'package:spotify/Models/playlist.dart';
import '../API_Providers/artistAPI.dart';

class PlaylistEndPoints {
  static const String playlists = '/playlists';
  static const String tracks = '/tracks';
  static const String popular = '/top?sort=-popularity';
  static const String mostRecent = '/top?sort=-createdAt';
  static const String pop = '/pop';
  static const String jazz = '/jazz';
  static const String arabic = '/arabic';
  static const String happy = '/happy';
  static const String artistCreated = '/created-playlists';
  static const browse = '/browse';
  static const categories = '/categories';
  static const madeForYou = "/recommended";
  static const String likedPlaylist = "/likedPlaylists";
  static const String me = "/me";
  static const String createdPlaylists = "/createdPlaylists";
  static const String likePlaylist = "/likePlaylist";
  static const String unlikePlaylist = "/unlikePlaylist";
  static const String createPlaylist = "/users/playlists";
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

  Future<List> fetchLikedPlaylistsApi(String token) async {
    final url =
        baseUrl + PlaylistEndPoints.me + PlaylistEndPoints.likedPlaylist;
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

  Future<List> fetchCreatedPlaylistsApi(String token) async {
    final url =
        baseUrl + PlaylistEndPoints.me + PlaylistEndPoints.createdPlaylists;
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



  Future<List> fetchMadeForYouPlaylistsApi(String token) async {
    final url =
        baseUrl + PlaylistEndPoints.playlists + PlaylistEndPoints.madeForYou;
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

  Future<bool> likePlaylist(String token, String playlistId) async {
    try {
      final responseData = await Dio()
          .put(baseUrl + PlaylistEndPoints.me + PlaylistEndPoints.likePlaylist,
              options: Options(
                  headers: {"authorization": "Bearer " + token},
                  validateStatus: (_) {
                    return true;
                  }),
              data: json.encode({
                "id": playlistId,
              }));
      print(responseData.statusCode);
      if (responseData.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<bool> unlikePlaylist(String token, String playlistId) async {
    try {
      final responseData = await Dio().delete(
          baseUrl + PlaylistEndPoints.me + PlaylistEndPoints.unlikePlaylist,
          options: Options(
              headers: {"authorization": "Bearer " + token},
              validateStatus: (_) {
                return true;
              }),
          data: json.encode({
            "id": playlistId,
          }));
      print(responseData.statusCode);
      if (responseData.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<Map<String, dynamic>> createPlaylistApi(
      String token, String name) async {
    final response =
        await Dio().post(baseUrl + PlaylistEndPoints.createPlaylist,
            data: json.encode(
              {
                "name": name,
              },
            ),
            options: Options(
              validateStatus: (_) {
                return true;
              },
              headers: {
                "authorization": "Bearer " + token,
              },
            ));
    if (response.statusCode == 200) {
      print(response.data);
      return response.data['playlist'];
    } else {
      throw HttpException(json.decode(response.data)['message'].toString());
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
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['tracksArray'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches top tracks for artist profile.
  ///takes [token],[ArtistId] as input parameters.
  Future<List> fetchArtistTopTracksApi(String token, String id) async {
    final url = baseUrl +
        ArtistEndPoints.artists +
        '/' +
        id +
        ArtistEndPoints.topTracks;

    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        final extractedList = temp['data'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches artist-created playlist(s).
  ///takes [token],[ArtistId] as input parameters.
  Future<List> fetchArtistPlaylistsApi(String token, String id) async {
    final url = baseUrl +
        ArtistEndPoints.artists +
        '/' +
        id +
        PlaylistEndPoints.artistCreated;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        final extractedList = temp['data'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
