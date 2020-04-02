//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//Import core libraries.
import 'dart:convert';

//Import Models.
import '../Models/playlist.dart';

///Class PlaylistProvider.
class PlaylistProvider with ChangeNotifier {
  ///List of playlist objects categorized as made for you playlists.
  List<Playlist> _madeForYouPlaylists = [];

  ///List of playlist objects categorized as popular playlists.
  List<Playlist> _popularPlaylists = [];

  ///List of playlist objects categorized as artist profile playlists.
  List<Playlist> _artistProfilePlaylists = [];

  ///List of playlist objects categorized as workout playlists.
  List<Playlist> _workoutPlaylists = [];

  ///A method(getter) that returns a list of playlists (made for you playlists).
  List<Playlist> get getMadeForYouPlaylists {
    return [..._madeForYouPlaylists];
  }

  ///A method(getter) that returns a list of playlists (popular playlists).
  List<Playlist> get getPopularPlaylists {
    return [..._popularPlaylists];
  }

  ///A method(getter) that returns a list of playlists (artist profile playlists).
  List<Playlist> get getArtistProfilePlaylists {
    return [..._artistProfilePlaylists];
  }

  ///A method(getter) that returns a list of playlists (workout playlists).
  List<Playlist> get getWorkoutPlaylists {
    return [..._workoutPlaylists];
  }

  void emptyLists() {
    _workoutPlaylists = [];
    _popularPlaylists = [];
    _madeForYouPlaylists = [];
  }

  ///A method that fetches for made for you playlists and set them in the made for you list.
  Future<void> fetchMadeForYouPlaylists() async {
    const url = 'http://www.mocky.io/v2/5e749227300000e613a5f49b';
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<Playlist> loadedPlaylists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
    }
    _madeForYouPlaylists = loadedPlaylists;
    notifyListeners();
  }

  ///A method that fetches for popular playlists and set them in the popular playlist list.
  Future<void> fetchPopularPlaylists() async {
    const url = 'http://www.mocky.io/v2/5e749724300000d431a5f4c6';
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    
    final List<Playlist> loadedPlaylists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
    }
    _popularPlaylists = loadedPlaylists;
    notifyListeners();
  }

  ///A method that fetches for workout playlists and set them in the workout list.
  Future<void> fetchWorkoutPlaylists() async {
    const url = 'http://www.mocky.io/v2/5e749c66300000d431a5f4f4';
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<Playlist> loadedPlaylists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
    }
    _workoutPlaylists = loadedPlaylists;
    notifyListeners();
  }

  ///A method that fetches for artist profile playlists and set them in the artist profle list.
  Future<void> fetchArtistProfilePlaylists() async {
    const url = 'http://www.mocky.io/v2/5e749c66300000d431a5f4f4';
    //const url = 'http://www.mocky.io/v2/5e6f9a36330000a7cbf07af1';
    //const url = 'http://www.mocky.io/v2/5e6e243e2f00005800a037ae';
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<Playlist> loadedPlaylists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
    }
    _artistProfilePlaylists = loadedPlaylists;
    notifyListeners();
  }
}
