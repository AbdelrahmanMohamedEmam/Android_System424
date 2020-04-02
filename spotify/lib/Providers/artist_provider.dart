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

  Future<Artist> get getChoosedArtist async{
    return _choosedArtist;
  }

  List<Artist> get getMultipleArtists {
    return [..._returnMultiple];
  }

  Future<void> fetchChoosedArtist() async {
    const url = 'http://www.mocky.io/v2/5e838e2b3000003a31cf3f05';
    print('pre');
    final response = await http.get(url);
    print('start');
    final extractedList = json.decode(response.body);
    _choosedArtist = Artist.fromJson(extractedList);
    print(extractedList);
    notifyListeners();
  }

  Future<void> fetchMultipleArtists() async {
    const url = 'http://www.mocky.io/v2/5e838e6b3000009900cf3f07';
    //print('bydrb abl get');
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<Artist> loadedArtists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedArtists.add(Artist.fromJson(extractedList[i]));
    }
    //print('read bro');
    //print(extractedList);
    //print(loadedArtists);

    _returnMultiple = loadedArtists;
    notifyListeners();
  }
}
