//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//Import core libraries.
import 'dart:convert';

//Import Models.
import '../Models/album.dart';

///Class AlbumProvider
class AlbumProvider with ChangeNotifier {
  ///List of album objects categorized as popular albums.
  List<Album> _popularAlbums = [];

  ///A method(getter) that returns a list of albums (popular albums).
  List<Album> get getPopularAlbums {
    return [..._popularAlbums];
  }

  ///A method that fetches for popular albums and set them in the popular albums list.
  Future<void> fetchPopularAlbums() async {
    const url = 'http://www.mocky.io/v2/5e74bc56300000d331a5f62f';
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<Album> loadedAlbum = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedAlbum.add(Album.fromJson(extractedList[i]));
    }
    _popularAlbums = loadedAlbum;
    notifyListeners();
  }
}
