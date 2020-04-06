//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:io';

//Import core libraries.
import 'dart:convert';

//Import Models.
import '../Models/album.dart';

///Class AlbumProvider
class AlbumProvider with ChangeNotifier {
  ///List of album objects categorized as popular albums.
  List<Album> _popularAlbums = [];
  ///List of album objects categorized as made b y artist albums.
  List<Album> _myAlbums = [];

  ///A method(getter) that returns a list of albums (popular albums).
  List<Album> get getPopularAlbums {
    return [..._popularAlbums];
  }

  ///A method(getter) that returns a list of albums (my albums).
  List<Album> get getMyAlbums {
    return [..._myAlbums];
  }

  //bool getSuccess() {
    //return _success;
  //}
  ///A method that fetches for popular albums and set them in the popular albums list.
  Future<void> fetchPopularAlbums() async {
    const url = 'http://www.mocky.io/v2/5e74bc56300000d331a5f62f';
    final response = await http.get(
        url);
    final extractedList = json.decode(
        response.body) as List;
    final List<Album> loadedAlbum = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedAlbum.add(
          Album.fromJson(
              extractedList[i]));
    }
    _popularAlbums = loadedAlbum;
    notifyListeners();
  }

  Future<void> fetchMyAlbums() async {
    const url = 'http://www.mocky.io/v2/5e8a21df2d00007b001a453e';
    final response = await http.get(url);
    final extractedList0 = json.decode(
        response.body) as List;
    final List<Album> loadedAlbum = [];
    for (int i = 0; i < extractedList0.length; i++) {
      loadedAlbum.add(
          Album.fromJson(
              extractedList0[i]));
    }
    _myAlbums = loadedAlbum;
    print(extractedList0);
    notifyListeners();
  }


  Future <bool> uploadImage(File file, String token, String albumName,
      String albumType, String _currentTime) async
  {
    //bool success;
    String _token = token;
    try {
      FormData formData = new FormData.fromMap(
          {
            "files": MultipartFile.fromFile(file.path,),
            "releaseDate": _currentTime,
            "name": albumName,
            "type": albumType,
            // "genres": ,
          }
      );
      Dio dio = new Dio();
      dio.options.headers["authorization"] = _token;
      Response response = await dio.post(
          'http://www.mocky.io/v2/5e7e7536300000e0134afb12', data: formData);
      notifyListeners();
      return true;
    } catch (response) {
      print('error');
      notifyListeners();
      return false;
    }
  }

  Future <bool> uploadSong (String path ,String token , String songName , String albumId) async
  {
    try {
      FormData formData = new FormData.fromMap(
          {
            "name" : songName,
            "trackAudio": MultipartFile.fromFile(path,),
          }
      );
      Dio dio = new Dio();
      dio.options.headers["authorization"] = token;
      Response response = await dio.post('http://www.mocky.io/v2/5e7e7536300000e0134afb12' //album id to be added to the url
           , data: formData );
      print(response);
      notifyListeners();
      return true;
      //_showScaffold("This is a SnackBar called from another place.");
    } catch(response)
    {
      print('error');
      notifyListeners();
      return false;
    }

  }
}