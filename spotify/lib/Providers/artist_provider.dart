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
    const url = 'http://www.mocky.io/v2/5e7114e830000086687a342a';
    final response = await http.get(
        url);
    final extractedList = json.decode(
        response.body);
    _choosedArtist = Artist.fromJson(
        extractedList);
    //print(extractedList);
    notifyListeners();
  }

  Future<void> fetchMultipleArtists() async {
    const url = 'http://www.mocky.io/v2/5e727d383300008c0044c95d';
    final response = await http.get(
        url);
    final extractedList = json.decode(
        response.body);
    final List<Artist> loadedArtists = [];

    for (int i = 0; i < extractedList.length; i++) {
      loadedArtists.add(
          Artist.fromJson(
              extractedList[i]));
    }
    //print(extractedList);

    _returnMultiple = loadedArtists;
    notifyListeners();
  }
}
