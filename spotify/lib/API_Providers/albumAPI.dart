///Importing dart libraries to use it.
import 'dart:convert';
//import 'dart:html';
import 'dart:ui';
import 'dart:core';
import 'dart:async';
import 'dart:collection';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/Models/http_exception.dart';
import '../API_Providers/artistAPI.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:image/image.dart' as img;


class AlbumEndPoints {
  static const String albums = '/albums';
  static const String popular = '/top?sort=-popularity';
  static const String mostRecent = '/top?sort=-createdAt';
  static const String forArtist = '/me';
  static const String track = '/tracks';
  static const String tracks = '/tracks';
  static const String meArtist = '/meArtist';
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

  Future<List> fetchMyAlbumsApi(String token) async {
    final url = baseUrl + AlbumEndPoints.forArtist + AlbumEndPoints.albums;
    try {
      final response = await http.get(
        url,
        headers: {'authorization': "Bearer " + token},
      );
      print(response.body);
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

  Future<List> fetchAlbumsTracksApi(String token, String id) async {
    final url =
        baseUrl + AlbumEndPoints.albums + '/' + id + AlbumEndPoints.tracks;
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

  ///A method that uploads new album in artist mode.
  ///takes [token],[albumName],[AudioFilePathInThePhone],[albumName],[ReleaseDate],[AlbumType] as input parameters.
  Future<bool> uploadAlbumApi(File image, String token, String albumName,
      String albumType, String _currentTime, String genre) async {
    final url = baseUrl + AlbumEndPoints.forArtist + AlbumEndPoints.albums;
    try {
      FormData formData = new FormData.fromMap({
        "name": albumName,
        "albumType": albumType,
        "genre": genre,
        "image": image,
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


  ///A method that edits new album in artist mode.
  ///takes [token],[albumName],[AudioFilePathInThePhone],[albumName],[AlbumType] as input parameters.
  Future<bool> editAlbumApi(File image, String token, String albumName,
      String albumID) async {
    final url = baseUrl + AlbumEndPoints.forArtist + AlbumEndPoints.albums + '/' + albumID;
    //List<int> imageBytes = await image.readAsBytes();
    //img.Image base64Image = img.decodeJpg(imageBytes);
//    print(image);
//    print(imageBytes);
//    print(base64Image);
//    print('mahmoud herexxxxx');
//    print( MultipartFile(image.openRead() ,  await image.length(),));
//    print(image.open());
//    print(image.openRead());
    try {
      FormData formData = new FormData.
      fromMap({
        "name": albumName,
        "image": image ,
      });
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      Response response = await dio.patch(
        url,
        data: formData,
        options: Options(contentType: 'multipart/form-data' ,validateStatus: (_) {
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
  Future<bool> deleteAlbumApi(String token , String albumID) async {
    final url =
        baseUrl + AlbumEndPoints.forArtist + AlbumEndPoints.albums + '/' + albumID;
    try {
      final response = await http.delete(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200 || response.statusCode == 204 ) {
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
  Future<bool> deleteSongApi(String token , String albumID , trackId) async {
    final url =
        baseUrl + AlbumEndPoints.forArtist + AlbumEndPoints.albums + '/' + albumID + AlbumEndPoints.track+ '/'+trackId;
    try {
      final response = await http.delete(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200 ||response.statusCode == 204) {
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
        AlbumEndPoints.forArtist +
        AlbumEndPoints.albums +
        '/' +
        albumId +
        AlbumEndPoints.track +
        '/' +
        songId;
    try {
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      Response response = await dio.patch(
        url,
        data: jsonEncode({"name" : songName}),
        options: Options(validateStatus: (_) {
          return true;
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
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
      String token, String songName, File path, String id) async {
    final url = baseUrl +
        AlbumEndPoints.forArtist +
        AlbumEndPoints.albums +
        '/' +
        id +
        AlbumEndPoints.track;
    try {
      FormData formData = new FormData.fromMap({
        "name": songName,
        "trackAudio": path.absolute,
      });
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "Bearer " + token;
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(contentType : 'mp3',validateStatus: (_) {
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
