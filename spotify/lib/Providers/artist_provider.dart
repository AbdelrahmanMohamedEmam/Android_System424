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
  Artist _choosedArtist;
  List<Artist> _returnMultiple = [];

  Artist get getChoosedArtist {
    return _choosedArtist;
  }

  List<Artist> get getMultipleArtists {
    return _returnMultiple;
  }

  Future<void> fetchChoosedArtist() async {
    const url = 'http://www.mocky.io/v2/5e6f9a36330000a7cbf07af1';
    final response = await http.get(
        url);
    final extractedList = json.decode(
        response.body);
    _choosedArtist = Artist.fromJson(
        extractedList);
    notifyListeners(
    );
  }

  Future<void> fetchMultipleArtists() async {
    const url = 'http://www.mocky.io/v2/5e6f9a36330000a7cbf07af1';
    final response = await http.get(
        url);
    final extractedList = json.decode(
        response.body) as List;
    final List<Artist> loadedArtists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedArtists.add(
          Artist.fromJson(
              extractedList[i]));
    }
    _returnMultiple = loadedArtists;
    notifyListeners();
  }
}
