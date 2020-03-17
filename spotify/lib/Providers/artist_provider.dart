import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_provider.dart';
import '../Models/user_stats.dart';
import '../Models/user.dart';
import 'package:spotify/Models/http_exception.dart';
import '../Models/artist.dart';

class ArtistProvider with ChangeNotifier {

  List<Artist> _artist = [];

  List<Artist> get artist {
    return [..._artist];
  }
/*
  Future<void> fetchPlaylistsForArtist() async {
    const url = 'http://www.mocky.io/v2/5e6e243e2f00005800a037ae';
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<Artist> loadedPlaylists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
    }
    _playlists = loadedPlaylists;
    notifyListeners();
  }*/
}

