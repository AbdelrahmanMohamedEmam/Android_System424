import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/playlist.dart';

class PlaylistProvider with ChangeNotifier {
  List<Playlist> _playlists = [];

  List<Playlist> get playlists {
    return [..._playlists];
  }

  Future<void> fetchPlaylists() async {
    const url = 'http://www.mocky.io/v2/5e6e243e2f00005800a037ae';
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<Playlist> loadedPlaylists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
    }
    _playlists = loadedPlaylists;
    notifyListeners();
  }
}
