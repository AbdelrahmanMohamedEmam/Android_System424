///Importing dart libraries to use it.
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/Models/http_exception.dart';
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
  static const String browse = '/browse';
  static const String categories = '/categories';
  static const String madeForYou = "/recommended";
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

  ///This method fetches popular playlists.
  ///It takes a [token] of type [String].
  ///It returns a [List] of type [Map<String,dynamic>].
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

  ///This method fetches most recent playlists.
  ///It takes a [token] of type [String].
  ///It returns a [List] of type [Map<String,dynamic>].
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

  ///This method fetches liked playlists.
  ///It takes a [token] of type [String].
  ///It returns a [List] of type [Map<String,dynamic>].
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

  ///This method fetches created playlists.
  ///It takes a [token] of type [String].
  ///It returns a [List] of type [Map<String,dynamic>].
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

  ///This method fetches made for you playlists.
  ///It takes a [token] of type [String].
  ///It returns a [List] of type [Map<String,dynamic>].
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

  ///This method fetches pop playlists.
  ///It takes a [token] of type [String] and [id] of type [String].
  ///It returns a [List] of type [Map<String,dynamic>].
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

  ///This method fetches random tracks for playlists.
  ///It takes a [token] of type [String] and [id] of type [String].
  ///It returns a [List] of type [Map<String,dynamic>].
  Future<List> fetchRandomTracksForPlaylistApi(String token, String id) async {
    final url = baseUrl +
        PlaylistEndPoints.playlists +
        '/' +
        id +
        PlaylistEndPoints.tracks +
        PlaylistEndPoints.madeForYou;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['tracks'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///This method fetches jazz playlists.
  ///It takes a [token] of type [String] and [id] of type [String].
  ///It returns a [List] of type [Map<String,dynamic>].
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

  ///This method fetches arabic playlists.
  ///It takes a [token] of type [String] and [id] of type [String].
  ///It returns a [List] of type [Map<String,dynamic>].
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

  ///This method fetches happy playlists.
  ///It takes a [token] of type [String] and [id] of type [String].
  ///It returns a [List] of type [Map<String,dynamic>].
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

  ///This method like a playlists.
  ///It takes a [token] of type [String] and [playlistId] of type [String].
  ///It returns a [bool] of true if success and false if fail.
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

  ///This method  unlike a playlists.
  ///It takes a [token] of type [String] and [playlistId] of type [String].
  ///It returns a [bool] of true if success and false if fail.
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

  ///This method creates a playlists.
  ///It takes a [token] of type [String] and [playlistName] of type [String].
  ///It returns a [Map<String,dynamic>] of the created playlist.
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

  ///This method creates a song.
  ///It takes a [token] of type [String] and [playlistId] of type [String] and [songId] of type [String].
  ///It returns a [Map<String,dynamic>] of added song.
  Future<Map<String, dynamic>> addSongToPlaylistApi(
      String token, String playlistID, String songID) async {
    try {
      final response = await Dio().post(
          baseUrl +
              PlaylistEndPoints.playlists +
              '/' +
              playlistID +
              PlaylistEndPoints.tracks,
          data: json.encode(
            {
              "id": songID,
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
    } catch (error) {
      throw HttpException(error).toString();
    }
  }

  ///A method that fetches a certain playlist tracks.
  ///It takes a [token] of type [String] and [PlaylistId] of type [String].
  ///It returns [List] of type [Map<String,dynamic>].
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
  ///It returns [List] of [Map<String,dynamic>].
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
      print('indicator');
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        final extractedList = temp['data'] as List;
        print(extractedList);
        print('indicator');
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
  ///It returns [List] of [Map<String,dynamic>].
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
        print(extractedList);
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches a- playlist(s).
  ///takes [token],[PlaylistId] as input parameters.
  ///It returns a [Map<String,dynamic>] of the fetched playlist.
  Future<Map<String, dynamic>> fetchPlaylistByIdApi(
      String token, String id) async {
    final url = baseUrl + PlaylistEndPoints.playlists + '/' + id;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        final extractedObject = temp['data']['playlist'];
        return extractedObject;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
