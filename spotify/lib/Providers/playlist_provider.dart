import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/playlist.dart';

class PlaylistProvider with ChangeNotifier {
  List<Playlist> _madeForYouPlaylists = [];
  List<Playlist> _popularPlaylists = [];

  List<Playlist> get getMadeForYouPlaylists {
    return [..._madeForYouPlaylists];
  }

  List<Playlist> get getPopularPlaylists {
    return [..._popularPlaylists];
  }

  Future<void> fetchMadeForYouPlaylists() async {
    //const url = 'http://www.mocky.io/v2/5e6fcb2333000061f1f07c23';
    const url = 'http://www.mocky.io/v2/5e6f9a36330000a7cbf07af1';
    //const url = 'http://www.mocky.io/v2/5e6e243e2f00005800a037ae';
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<Playlist> loadedPlaylists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
    }
    print('hi');
    _madeForYouPlaylists = loadedPlaylists;
    notifyListeners();
  }

  Future<void> fetchPopularPlaylists() async {
    const url = 'http://www.mocky.io/v2/5e6fcb2333000061f1f07c23';
    //const url = 'http://www.mocky.io/v2/5e6f9a36330000a7cbf07af1';
    //const url = 'http://www.mocky.io/v2/5e6e243e2f00005800a037ae';
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<Playlist> loadedPlaylists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
    }
    _popularPlaylists = loadedPlaylists;
    notifyListeners();
  }
}
