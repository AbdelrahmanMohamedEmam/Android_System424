//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:spotify/API_Providers/albumAPI.dart';
import 'package:spotify/Models/track.dart';
import 'dart:io';

//Import core libraries.
import 'dart:convert';

//Import Models.
import '../Models/album.dart';

enum AlbumCategory {
  popularAlbums,
  mostRecentAlbums,
  myAlbums,
}

///Class AlbumProvider
class AlbumProvider with ChangeNotifier {
  final String baseUrl;

  AlbumProvider({this.baseUrl});

  ///List of album objects categorized as popular albums.
  List<Album> _popularAlbums = [];

  ///List of album objects categorized as popular albums.
  List<Album> _mostrecentAlbums = [];

  ///List of album objects categorized as made b y artist albums.
  List<Album> _myAlbums = [];

  ///A method(getter) that returns a list of albums (popular albums).
  List<Album> get getPopularAlbums {
    return [..._popularAlbums];
  }

  ///A method(getter) that returns a list of albums (my albums).
  List<Album> get getMyAlbums {
    return [..._myAlbums];
  }

  ///A method(getter) that returns a list of albums (my albums).
  List<Album> get getMostRecentAlbums {
    return [..._mostrecentAlbums];
  }

  Album getMostRecentAlbumsId(String id) {
    final albumIndex = _mostrecentAlbums.indexWhere((album) => album.id == id);
    return _mostrecentAlbums[albumIndex];
  }

  Album getPopularAlbumsId(String id) {
    final albumIndex = _popularAlbums.indexWhere((album) => album.id == id);
    return _popularAlbums[albumIndex];
  }

  void emptyLists() {
    _popularAlbums = [];
    _mostrecentAlbums = [];
  }

  //bool getSuccess() {
  //return _success;
  //}

  ///A method that fetches for popular albums and set them in the popular albums list.
  Future<void> fetchPopularAlbums(String token) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      final extractedList = await albumApi.fetchPopularAlbumsApi(token);
      final List<Album> loadedAlbum = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedAlbum.add(Album.fromJson(extractedList[i]));
      }
      _popularAlbums = loadedAlbum;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches for popular albums and set them in the popular albums list.
  Future<void> fetchMostRecentAlbums(String token) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      final extractedList = await albumApi.fetchMostRecentAlbumsApi(token);
      final List<Album> loadedAlbum = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedAlbum.add(Album.fromJson(extractedList[i]));
      }
      _mostrecentAlbums = loadedAlbum;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<void> fetchMyAlbums(String token, String id) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      final extractedList = await albumApi.fetchMyAlbumsApi(token, id);
      final List<Album> loadedAlbum = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedAlbum.add(Album.fromJson(extractedList[i]));
      }
      _myAlbums = loadedAlbum;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<void> fetchArtistAlbums(String token, String id) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      final extractedList = await albumApi.fetchArtistAlbumsApi(token, id);
      final List<Album> loadedAlbum = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedAlbum.add(Album.fromJson(extractedList[i]));
      }
      _myAlbums = loadedAlbum;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<void> fetchMostRecentAlbumsById(String id, String token) async {
    AlbumAPI albumAPI = AlbumAPI(baseUrl: baseUrl);
    try {
      Album album = getMostRecentAlbumsId(id);
      final List<Track> loadedTracks = [];
      final extractedList = await albumAPI.fetchAlbumsTracksApi(token, id);

      for (int i = 0; i < extractedList.length; i++) {
        loadedTracks.add(Track.fromJsonAlbum(extractedList[i]));
      }
      album.tracks = loadedTracks;
      final albumIndex =
          _mostrecentAlbums.indexWhere((album) => album.id == id);
      _mostrecentAlbums.removeAt(albumIndex);
      _mostrecentAlbums.insert(albumIndex, album);
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<void> fetchPopularAlbumsById(String id, String token) async {
    AlbumAPI albumAPI = AlbumAPI(baseUrl: baseUrl);
    try {
      Album album = getPopularAlbumsId(id);
      final List<Track> loadedTracks = [];
      final extractedList = await albumAPI.fetchAlbumsTracksApi(token, id);

      for (int i = 0; i < extractedList.length; i++) {
        loadedTracks.add(Track.fromJsonAlbum(extractedList[i]));
      }
      album.tracks = loadedTracks;
      final albumIndex = _popularAlbums.indexWhere((album) => album.id == id);
      _popularAlbums.removeAt(albumIndex);
      _popularAlbums.insert(albumIndex, album);
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<bool> uploadImage(File file, String token, String albumName,
      String albumType, String _currentTime) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      bool check = await albumApi.uploadAlbumApi(
          file, token, albumName, albumType, _currentTime);
      return check;
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<bool> uploadSong(String token, String songName, String path) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      bool check = await albumApi.uploadSongApi(token, songName, path);
      return check;
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<void> fetchAlbumsTracksById(
      String id, String token, AlbumCategory albumCategory) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      ////////////////////////////////////////////////////////////
      final List<Track> loadedTracks = [];
      if (albumCategory == AlbumCategory.mostRecentAlbums) {
        Album album = getMostRecentAlbumsId(id);
        if (!album.isFetched) {
          final extractedList = await albumApi.fetchAlbumsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJsonAlbum(extractedList[i]));
          }
          album.tracks = loadedTracks;
          final albumIndex =
              _mostrecentAlbums.indexWhere((album) => album.id == id);
          _mostrecentAlbums.removeAt(albumIndex);
          album.isFetched = true;
          _mostrecentAlbums.insert(albumIndex, album);
        } else {
          return;
        }
      }
      //////////////////////////////////////////////////////////////////////
      if (albumCategory == AlbumCategory.popularAlbums) {
        Album album = getPopularAlbumsId(id);
        if (!album.isFetched) {
          final extractedList = await albumApi.fetchAlbumsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJsonAlbum(extractedList[i]));
          }
          album.tracks = loadedTracks;
          final albumIndex =
              _popularAlbums.indexWhere((album) => album.id == id);
          _popularAlbums.removeAt(albumIndex);
          album.isFetched = true;
          _popularAlbums.insert(albumIndex, album);
        } else {
          return;
        }
      }
      
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
