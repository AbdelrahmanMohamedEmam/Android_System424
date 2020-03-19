import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/album.dart';

class AlbumProvider with ChangeNotifier {
  List<Album> _popularAlbums = [];
  List<Album> get getPopularAlbums {
    return [..._popularAlbums];
  }

  Future<void> fetchPopularAlbums() async {
    const url = 'http://www.mocky.io/v2/5e71e9bc3300004f0044c4ab';
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
