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
  Artist _choosedArtist;
  List<Artist> _returnMultiple = [];
  List<Artist> _returnAll = [];

  Future<Artist> get getChoosedArtist async {
    return _choosedArtist;
  }

  List<Artist> get getMultipleArtists {
    return [..._returnMultiple];
  }
///getter for all artists for sign up
  List<Artist> get getAllArtists {
    return [..._returnAll];
  }

  Future<void> fetchChoosedArtist() async {
    const url = 'http://www.mocky.io/v2/5e838e2b3000003a31cf3f05';
    final response = await http.get(url);
    final extractedList = json.decode(
        response.body);
    _choosedArtist = Artist.fromJson(extractedList);
    notifyListeners(
    );
  }

  Future<void> fetchMultipleArtists() async {
    const url ="http://www.mocky.io/v2/5e87635f3100002a003f44d4";
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<Artist> loadedArtists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedArtists.add(Artist.fromJson(extractedList[i]));
    }
    _returnMultiple = loadedArtists;
    notifyListeners(
    );
  }

  ///function to get all artists for the 1st sign up
  Future<void> fetchAllArtists() async {
    const url = "http://www.mocky.io/v2/5e87635f3100002a003f44d4";
    final response = await http.get(
        url);
    final extractedList = json.decode(
        response.body) as List;
    print(
        extractedList.length);
    final List<Artist> loadedArtists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedArtists.add(
          Artist.fromJson(
              extractedList[i]));
    }
    _returnAll = loadedArtists;
    notifyListeners(
    );
  }
}
