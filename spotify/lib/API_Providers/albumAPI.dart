///Importing dart libraries to use it.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify/Models/http_exception.dart';
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
        print(extractedList[0]);
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
        print(extractedList);
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchMyAlbumsApi(String token) async {
    final url = baseUrl + AlbumEndPoints.forArtist + AlbumEndPoints.albums;
    try {
      final response = await http.get(
        url,
        headers: {'authorization': "Bearer " + token},
      );
      print(response.body);
      print(response.statusCode);
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
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        print(response.statusCode);
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

  Future<List> fetchAlbumsTracksApi(String token, String id) async {
    final url =
        baseUrl + AlbumEndPoints.albums + '/' + id + AlbumEndPoints.tracks;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        print(response.body);
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

  ///A method that uploads new album in artist mode.
  ///takes [token],[albumName],[AudioFilePathInThePhone],[albumName],[ReleaseDate],[AlbumType] as input parameters.
  Future<bool> uploadAlbumApi(String filePath, String token, String albumName,
      String albumType, String _currentTime, String genre) async {
    final url = baseUrl + AlbumEndPoints.forArtist + AlbumEndPoints.albums;
    try {
      FormData formData = new FormData.fromMap({
        "releaseDate": _currentTime,
        "name": albumName,
        "albumType": albumType,
        "genre": genre,
        //"image": MultipartFile.fromFile(
          //filePath,
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
