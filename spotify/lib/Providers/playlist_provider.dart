//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/API_Providers/playlistAPI.dart';
import 'package:spotify/Models/http_exception.dart';
import 'package:spotify/Models/track.dart';

//Import core libraries.
import 'dart:convert';

//Import Models.
import '../Models/playlist.dart';

///Class PlaylistProvider.
class PlaylistProvider with ChangeNotifier {
  final String baseUrl;
  PlaylistProvider({this.baseUrl});

  ///List of playlist objects categorized as made for you playlists.
  List<Playlist> _mostRecentPlaylists = [];

  ///List of playlist objects categorized as popular playlists.
  List<Playlist> _popularPlaylists = [];

  ///List of playlist objects categorized as artist profile playlists.
  List<Playlist> _artistProfilePlaylists = [];

  ///List of playlist objects categorized as workout playlists.
  List<Playlist> _popPlaylists = [];

  ///List of playlist objects categorized as workout playlists.
  List<Playlist> _jazzPlaylists = [];

  ///A method(getter) that returns a list of playlists (made for you playlists).
  List<Playlist> get getMostRecentPlaylists {
    return [..._mostRecentPlaylists];
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
  List<Playlist> get getpopPlaylists {
    return [..._popPlaylists];
  }

  ///A method(getter) that returns a list of playlists (workout playlists).
  List<Playlist> get getJazzPlaylists {
    return [..._jazzPlaylists];
  }

  Playlist getMostRecentPlaylistsId(String id) {
    final playlistIndex =
        _mostRecentPlaylists.indexWhere((playlist) => playlist.id == id);
    return _mostRecentPlaylists[playlistIndex];
  }

  void emptyLists() {
    _popPlaylists = [];
    _popularPlaylists = [];
    _mostRecentPlaylists = [];
  }

  ///A method that fetches for made for you playlists and set them in the made for you list.
  Future<void> fetchMostRecentPlaylists(String token) async {
    PlaylistAPI playlistApi = PlaylistAPI(baseUrl: baseUrl);
    try {
      final extractedList =
          await playlistApi.fetchMostRecentPlaylistsApi(token);

      final List<Playlist> loadedPlaylists = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
      }
      _mostRecentPlaylists = loadedPlaylists;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches for popular playlists and set them in the popular playlist list.
  Future<void> fetchPopularPlaylists(String token) async {
    PlaylistAPI playlistApi = PlaylistAPI(baseUrl: baseUrl);
    try {
      final extractedList = await playlistApi.fetchPopularPlaylistsApi(token);

      final List<Playlist> loadedPlaylists = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
      }
      _popularPlaylists = loadedPlaylists;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches for workout playlists and set them in the workout list.
  Future<void> fetchPopPlaylists(String token) async {
    PlaylistAPI playlistApi = PlaylistAPI(baseUrl: baseUrl);
    try {
      final extractedList = await playlistApi.fetchPopPlaylistsApi(token);

      final List<Playlist> loadedPlaylists = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
      }
      _popPlaylists = loadedPlaylists;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches for workout playlists and set them in the workout list.
  Future<void> fetchJazzPlaylists(String token) async {
    PlaylistAPI playlistApi = PlaylistAPI(baseUrl: baseUrl);
    try {
      final extractedList = await playlistApi.fetchJazzPlaylistsApi(token);

      final List<Playlist> loadedPlaylists = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
      }
      _jazzPlaylists = loadedPlaylists;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
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

  Future<void> fetchMadeForYouPlaylistTracksById(String id) async {
    const url = 'http://www.mocky.io/v2/5e890f423100007b00d39bd2';
    Playlist playlist = getMostRecentPlaylistsId(id);
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<Track> loadedTracks = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedTracks.add(Track.fromJson2(extractedList[i]));
    }
    playlist.tracks2 = loadedTracks;
    final playlistIndex =
        _mostRecentPlaylists.indexWhere((playlist) => playlist.id == id);
    _mostRecentPlaylists.removeAt(playlistIndex);
    _mostRecentPlaylists.insert(playlistIndex, playlist);
  }
}
