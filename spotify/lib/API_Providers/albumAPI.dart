///Importing dart libraries to use it.
import 'dart:convert';
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
  static const String likedAlbums = "/likedAlbums";
  static const String me = "/me";
  static const String likeAlbum = "/likeAlbum";
  static const String unlikeAlbum = "/unlikeAlbum";
}

class AlbumAPI {
  final String baseUrl;
  AlbumAPI({this.baseUrl});

  ///A method that fetches popular albums.
  ///Takes [token] of type [String] as input parameters.
  ///It returns [List] of popular albums of type [Map<String,dynamic>].
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

  ///A method that fetches most recent albums.
  ///Takes [token] of type [String] as input parameters.
  ///It returns [List] of most recent albums of type [Map<String,dynamic>].
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

  ///A method that fetches liked albums.
  ///Takes [token] of type [String] as input parameters.
  ///It returns [List] of liked albums of type [Map<String,dynamic>].
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

  ///A method that likes a certain album.
  ///Takes [token] of type [String] and [albumId] of typr [String]as input parameters.
  ///It returns [bool] true if success and false if fail.
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

  ///A method that unlikes a certain album.
  ///Takes [token] of type [String] and [albumId] of typr [String]as input parameters.
  ///It returns [bool] true if success and false if fail.
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

  ///A method to fetch a user artists albums.
  ///Takes [token] of type [String] as input parameters.
  ///It returns [List] of user artist's albums of type [Map<String,dynamic>].
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

  ///A method to fetch a artists albums.
  ///Takes [token] of type [String] and [id] of type [String] as input parameters.
  ///It returns [List] of  artist albums of type [Map<String,dynamic>].
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

  ///A method that fetches an-album..
  ///takes [token],[AlbumId] of type [String] as input parameters.
  ///Returns an album object of type [Map<String,dynamic>].
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

  ///A method to fetch album tracks.
  ///Takes [token] of type [String] and [id] of type [String] as input parameters.
  ///It returns [List] of  album tracks of type [Map<String,dynamic>].
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
  ///It returns [bool] true if success and false if fail.
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
  ///It returns [bool] true if success and false if fail.
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

  ///A method that edits a song in artist mode.
  ///takes [token],[songName],[albumId],[songId] of type [String] as input parameters.
  ///It returns [bool] true if success and false if fail.
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
  ///It returns [bool] true if success and false if fail.
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
