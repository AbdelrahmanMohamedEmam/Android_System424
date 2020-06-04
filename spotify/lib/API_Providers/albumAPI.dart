///Importing dart libraries to use it.
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/Models/http_exception.dart';
import 'package:spotify/Providers/album_provider.dart';
import '../API_Providers/artistAPI.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class AlbumEndPoints {
  static const String albums = '/albums';
  static const String popular = '/top?sort=-popularity';
  static const String mostRecent = '/top?sort=-createdAt';
  static const String forArtist = '/me';
  static const String track = '/tracks';
  static const String tracks = '/tracks';
  static const String meArtist = '/meArtist';
  static const String likedAlbums = "/likedAlbums";
  static const String me = "/me";
  static const String likeAlbum = "/likeAlbum";
  static const String unlikeAlbum = "/unlikeAlbum";
}

class AlbumAPI {
  final String baseUrl;
  AlbumAPI({this.baseUrl});

  Future<List> fetchPopularAlbumsApi(String token) async {
    final url = baseUrl + AlbumEndPoints.albums + AlbumEndPoints.popular;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['albums'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchMostRecentAlbumsApi(String token) async {
    final url = baseUrl + AlbumEndPoints.albums + AlbumEndPoints.mostRecent;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['albums'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchLikedAlbumsApi(String token) async {
    final url = baseUrl + AlbumEndPoints.me + AlbumEndPoints.likedAlbums;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['albums'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<bool> likeAlbum(String token, String albumId) async {
    try {
      final responseData = await Dio()
          .put(baseUrl + AlbumEndPoints.me + AlbumEndPoints.likeAlbum,
              options: Options(
                  headers: {"authorization": "Bearer " + token},
                  validateStatus: (_) {
                    return true;
                  }),
              data: json.encode({
                "id": albumId,
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

  Future<bool> unlikeAlbum(String token, String albumId) async {
    try {
      final responseData = await Dio()
          .delete(baseUrl + AlbumEndPoints.me + AlbumEndPoints.unlikeAlbum,
              options: Options(
                  headers: {"authorization": "Bearer " + token},
                  validateStatus: (_) {
                    return true;
                  }),
              data: json.encode({
                "id": albumId,
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

  Future<List> fetchMyAlbumsApi(String token) async {
    final url = baseUrl + AlbumEndPoints.forArtist + AlbumEndPoints.albums;
    try {
      final response = await http.get(
        url,
        headers: {'authorization': "Bearer " + token},
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

  Future<List> fetchArtistAlbumsApi(String token, String id) async {
    final url =
        baseUrl + ArtistEndPoints.artists + '/' + id + AlbumEndPoints.albums;
    try {
      final response = await http.get(
        url,
        headers: {'authorization': "Bearer " + token},
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

  ///A method that fetches an- album..
  ///takes [token],[AlbumId] as input parameters.
  Future<Map<String, dynamic>> fetchAlbumByIdApi(
      String token, String id) async {
    final url = baseUrl + AlbumEndPoints.albums + '/' + id;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        final extractedObject = temp['data']['album'];
        return extractedObject;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchAlbumsTracksApi(String token, String id) async {
    final url =
        baseUrl + AlbumEndPoints.albums + '/' + id + AlbumEndPoints.tracks;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      print('cccc');
      print(response.statusCode);
      print('xxxx');
      print(response.body);
      print('xxxx');
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        print(temp);
        Map<String, dynamic> temp2 = temp['data'];
        print(temp2);
        final extractedList = temp2['tracksArray'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that uploads new album in artist mode.
  ///takes [token],[albumName],[AudioFilePathInThePhone],[albumName],[ReleaseDate],[AlbumType] as input parameters.
  Future<bool> uploadAlbumApi(File image, String token, String albumName,
      String albumType, String _currentTime, String genre) async {
    final url = baseUrl + AlbumEndPoints.forArtist + AlbumEndPoints.albums;
    try {
      FormData formData = new FormData.fromMap({
        //"releaseDate": _currentTime,
        "name": albumName,
        "albumType": albumType,
        "genre": genre,
        "image": base64Encode(image.readAsBytesSync()),
      });
      Dio dio = new Dio();
      print('ready');
      dio.options.headers["authorization"] = "Bearer " + token;
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(validateStatus: (_) {
          return true;
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that edits new album in artist mode.
  ///takes [token],[albumName],[AudioFilePathInThePhone],[albumName],[AlbumType] as input parameters.
  Future<bool> editAlbumApi(File image, String token, String albumName,
      String albumType, String genre) async {
    ///must be modified//////////////////////////////////////////////////////
    final url = baseUrl +
        AlbumEndPoints.forArtist +
        AlbumEndPoints
            .albums; //this is the same url of add album needs to be modified
    /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    try {
      FormData formData = new FormData.fromMap({
        "name": albumName,
        "albumType": albumType,
        "genre": genre,
        "image": FileImage(image),
      });
      Dio dio = new Dio();
      print('ready');
      dio.options.headers["authorization"] = "Bearer " + token;
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(validateStatus: (_) {
          return true;
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that deletes new album in artist mode.
  ///takes [token],[albumID]as input parameters.
  Future<bool> deleteAlbumApi(String token, String albumID) async {
    final url = baseUrl +
        AlbumEndPoints.meArtist +
        AlbumEndPoints.albums +
        '/' +
        albumID;
    try {
      final response = await http.delete(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that deletes new album in artist mode.
  ///takes [token],[albumID] , [trackId]as input parameters.
  Future<bool> deleteSongApi(String token, String albumID, trackId) async {
    final url = baseUrl +
        AlbumEndPoints.meArtist +
        AlbumEndPoints.albums +
        '/' +
        albumID +
        AlbumEndPoints.track +
        '/' +
        trackId;
    try {
      final response = await http.delete(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<bool> editSongApi(
      String token, String songName, String albumId, String songId) async {
    final url = baseUrl +
        AlbumEndPoints.meArtist +
        AlbumEndPoints.albums +
        '/' +
        albumId +
        AlbumEndPoints.track +
        '/' +
        songId;
    try {
      FormData formData = new FormData.fromMap({
        "name": songName,
      });
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      Response response = await dio.put(
        url,
        data: formData,
        options: Options(validateStatus: (_) {
          return true;
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that uploads new song in artist mode.
  ///takes [token] , [SongName] , [songPathInThePhone] , [albumID] as input parameters.
  Future<bool> uploadSongApi(
      String token, String songName, String path, String id) async {
    final url = baseUrl +
        AlbumEndPoints.forArtist +
        AlbumEndPoints.albums +
        '/' +
        id +
        AlbumEndPoints.track;
    try {
      FormData formData = new FormData.fromMap({
        "name": songName,
        //"trackAudio": MultipartFile.fromFile(
        // path,
        //),
      });
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(validateStatus: (_) {
          return true;
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
