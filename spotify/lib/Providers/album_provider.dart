//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'dart:io';

//Importing API provider.
import 'package:spotify/API_Providers/albumAPI.dart';

//Import Models.
import '../Models/album.dart';
import 'package:spotify/Models/track.dart';

///Enum To describe Category of the album ex:(Popular,Most Recent,...).
enum AlbumCategory {
  recentlyPlayed,
  popularAlbums,
  mostRecentAlbums,
  myAlbums,
  artist,
  search,
  artistMode,
  liked,
}

///Class AlbumProvider
class AlbumProvider with ChangeNotifier {
  ///The base Url for this provider.
  final String baseUrl;

  ///Constructor with named arguments assignment.
  AlbumProvider({this.baseUrl});

  ///List of album objects categorized as popular albums.
  List<Album> _popularAlbums = [];

  ///List of album objects categorized as Most Recent albums.
  List<Album> _mostrecentAlbums = [];

  ///List of album objects categorized as made by artist albums.
  List<Album> _myAlbums = [];

  ///List of album objects categorized as the artist albums.
  List<Album> artistAlbums = [];

  //List<Album> artistModeAlbums = [];
  ///List of album objects categorized as the search albums.
  List<Album> searchedAlbums = [];

  ///List of album objects categorized as liked albums.
  List<Album> _likedAlbums = [];

  ///List of album objects categorized as recently played albums.
  List<Album> _recentlyPlayed = [];

  ///A method(getter) that returns a list of albums (popular albums).
  List<Album> get getPopularAlbums {
    return [..._popularAlbums];
  }

  ///A method(getter) that returns a list of albums (searched albums).
  List<Album> get getSearchedAlbums {
    return [...searchedAlbums];
  }

  ///A method(getter) that returns a list of albums (artistAlbums).
  List<Album> get getArtistAlbums {
    return [...artistAlbums];
  }

  ///A method(getter) that returns a list of albums (my albums).
  List<Album> get getMyAlbums {
    return [..._myAlbums];
  }

  ///A method(getter) that returns a list of albums (liked albums).
  List<Album> get getLikedAlbums {
    return [..._likedAlbums];
  }

  ///A method(getter) that returns a list of albums (mostrecentAlbums).
  List<Album> get getMostRecentAlbums {
    return [..._mostrecentAlbums];
  }

  ///A method that takes an id for an album and returns the album object with this id located at the MostRecentAlbums List
  Album getMostRecentAlbumsId(String id) {
    final albumIndex = _mostrecentAlbums.indexWhere((album) => album.id == id);
    return _mostrecentAlbums[albumIndex];
  }

  ///A method that takes an id for an album and returns the album object with this id located at the likedAlbums List
  Album getLikedAlbumsId(String id) {
    final albumIndex = _likedAlbums.indexWhere((album) => album.id == id);
    return _likedAlbums[albumIndex];
  }

  ///A method that takes an id for an album and returns the album object with this id located at the PopularAlbums List
  Album getPopularAlbumsId(String id) {
    final albumIndex = _popularAlbums.indexWhere((album) => album.id == id);
    return _popularAlbums[albumIndex];
  }

  ///A method that takes an id for an album and returns the album object with this id located at the searchalbums List
  Album getSearchedAlbumsId(String id) {
    final albumIndex = searchedAlbums.indexWhere((album) => album.id == id);
    return searchedAlbums[albumIndex];
  }

  ///A method that takes an id for an album and returns the album object with this id located at the searchalbums List
  Album getRecentlyPlayedAlbumsById(String id) {
    final albumIndex = _recentlyPlayed.indexWhere((album) => album.id == id);
    return _recentlyPlayed[albumIndex];
  }

  ///A method that takes an id for an album and returns the album object with this id located at the MyAlbums List
  Album getMyAlbumId(String id) {
    final albumIndex = _myAlbums.indexWhere((album) => album.id == id);
    return _myAlbums[albumIndex];
  }

  ///A method to empty the lists from album objects.
  void emptyLists() {
    _popularAlbums = [];
    _mostrecentAlbums = [];
  }

  void emptySearchList() {
    searchedAlbums = [];
  }

  void setSearchAlbum(Album searchedAlbum) {
    searchedAlbums.add(searchedAlbum);
  }

  ///Checks if track with a certain id is liked
  bool isAlbumLiked(String id) {
    if (_likedAlbums.isEmpty) {
      return false;
    }
    if (_likedAlbums.indexWhere((album) => album.id == id) != -1) {
      return true;
    }
    return false;
  }

  Future<bool> likeAlbum(
      String token, String albumID, AlbumCategory category) async {
    AlbumAPI albumAPI = AlbumAPI(baseUrl: baseUrl);
    Album album;
    try {
      final response = await albumAPI.likeAlbum(token, albumID);
      if (category == AlbumCategory.popularAlbums)
        album = getPopularAlbumsId(albumID);
      else if (category == AlbumCategory.mostRecentAlbums)
        album = getMostRecentAlbumsId(albumID);
      else if (category == AlbumCategory.liked)
        album = getLikedAlbumsId(albumID);
      else if (category == AlbumCategory.search)
        album = getSearchedAlbumsId(albumID);
      else if (category == AlbumCategory.myAlbums)
        album = getMyAlbumId(albumID);
      else if (category == AlbumCategory.recentlyPlayed)
        album = getRecentlyPlayedAlbumsById(albumID);
      _likedAlbums.add(album);
      notifyListeners();
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> unlikeAlbum(String token, String albumId) async {
    AlbumAPI albumAPI = AlbumAPI(baseUrl: baseUrl);
    try {
      final response = await albumAPI.unlikeAlbum(token, albumId);
      if (true) {
        int index = _likedAlbums.indexWhere((album) => album.id == albumId);
        if (index != -1) {
          _likedAlbums.removeAt(index);
        }
        notifyListeners();
        return response;
      }
    } catch (error) {
      throw error;
    }
  }

  ///A method that fetches for popular albums and set them in the popular albums list.
  ///It requires a parameter of type [String] token to verify the user.
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

  ///A method that fetches for Most Recent albums and set them in the Most Recent albums list.
  ///It requires a parameter of type [String] token to verify the user.
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

  ///A method that fetches for Most Recent albums and set them in the Most Recent albums list.
  ///It requires a parameter of type [String] token to verify the user.
  Future<void> fetchLikedAlbums(String token) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      final extractedList = await albumApi.fetchLikedAlbumsApi(token);
      final List<Album> loadedAlbum = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedAlbum.add(Album.fromJson(extractedList[i]));
      }
      _likedAlbums = loadedAlbum;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches for Most Recent albums and set them in the My Albums  list.
  ///It requires a parameter of type [String] token to verify the user.
  Future<void> fetchMyAlbums(String token) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      final extractedList = await albumApi.fetchMyAlbumsApi(token);
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

  ///A method that fetches for recentlyplayed Album and set it in the recently Album list.
  ///It takes a [String] ,[PlaylistId]token for verification.
  Future<void> fetchRecentlyPlayedAlbum(String token, String id) async {
    AlbumAPI albumsApi = AlbumAPI(baseUrl: baseUrl);
    try {
      final extractedList = await albumsApi.fetchAlbumByIdApi(token, id);
      Album temp = Album.fromJson(extractedList);
      _recentlyPlayed.add(temp);
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches for Most Recent albums and set them in the Artists albums  list.
  Future<void> fetchArtistAlbums(String token, String id) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      final extractedList = await albumApi.fetchArtistAlbumsApi(token, id);
      final List<Album> loadedAlbum = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedAlbum.add(Album.fromJson(extractedList[i]));
      }
      artistAlbums = loadedAlbum;
      notifyListeners();

      _myAlbums = loadedAlbum;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<bool> uploadImage(File image, String token, String albumName,
      String albumType, String _currentTime, String genre) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      bool check = await albumApi.uploadAlbumApi(
          image, token, albumName, albumType, _currentTime, genre);
      return check;
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<bool> editAlbum(File image, String token, String albumName,
      String albumType, String genre) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      bool check = await albumApi.editAlbumApi(
          image, token, albumName, albumType, genre);
      return check;
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<bool> deleteAlbum(String token, String id) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      bool check = await albumApi.deleteAlbumApi(token, id);
      return check;
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<bool> deleteSong(String token, String albumId, String trackId) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      bool check = await albumApi.deleteSongApi(token, albumId, trackId);
      return check;
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<bool> editSong(
      String token, String songName, String albumId, String trackId) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      bool check =
          await albumApi.editSongApi(token, songName, albumId, trackId);
      return check;
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that uploads new song in artist mode.
  Future<bool> uploadSong(
      String token, String songName, String path, String id) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      bool check = await albumApi.uploadSongApi(token, songName, path, id);
      return check;
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches for a tracks for a certain album in the albums List according to the [AlbumCategory].
  ///It takes a [string] token for verification and id for identification,[AlbumCategory] to identify which list to add in.
  Future<void> fetchAlbumsTracksById(
      String id, String token, AlbumCategory albumCategory) async {
    AlbumAPI albumApi = AlbumAPI(baseUrl: baseUrl);
    try {
      final List<Track> loadedTracks = [];
      if (albumCategory == AlbumCategory.mostRecentAlbums) {
        Album album = getMostRecentAlbumsId(id);
        if (!album.isFetched) {
          final extractedList = await albumApi.fetchAlbumsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
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
      if (albumCategory == AlbumCategory.popularAlbums) {
        Album album = getPopularAlbumsId(id);
        if (!album.isFetched) {
          final extractedList = await albumApi.fetchAlbumsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
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
      if (albumCategory == AlbumCategory.liked) {
        Album album = getLikedAlbumsId(id);
        if (!album.isFetched) {
          final extractedList = await albumApi.fetchAlbumsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
          }
          album.tracks = loadedTracks;
          final albumIndex = _likedAlbums.indexWhere((album) => album.id == id);
          _likedAlbums.removeAt(albumIndex);
          album.isFetched = true;
          _likedAlbums.insert(albumIndex, album);
        } else {
          return;
        }
      }
      if (albumCategory == AlbumCategory.artist) {
        Album album = getMyAlbumId(id);
        if (!album.isFetched) {
          final extractedList = await albumApi.fetchAlbumsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
          }
          album.tracks = loadedTracks;
          final albumIndex = artistAlbums.indexWhere((album) => album.id == id);
          artistAlbums.removeAt(albumIndex);
          album.isFetched = true;
          artistAlbums.insert(albumIndex, album);
        } else {
          return;
        }
      }
      if (albumCategory == AlbumCategory.myAlbums) {
        Album album = getMyAlbumId(id);
        if (!album.isFetched) {
          final extractedList = await albumApi.fetchAlbumsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
          }
          album.tracks = loadedTracks;
          print('loadedTracks');
          //print(loadedTracks[0].name);
          final albumIndex = _myAlbums.indexWhere((album) => album.id == id);
          _myAlbums.removeAt(albumIndex);
          print(albumIndex);
          album.isFetched = true;
          _myAlbums.insert(albumIndex, album);
          print('checkkk');
          print(albumIndex);
          print(_myAlbums[0].tracks[0].name);
        } else {
          return;
        }
      }

      if (albumCategory == AlbumCategory.search) {
        Album album = getSearchedAlbumsId(id);
        if (!album.isFetched) {
          final extractedList = await albumApi.fetchAlbumsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
          }
          album.tracks = loadedTracks;
          final albumIndex =
              searchedAlbums.indexWhere((album) => album.id == id);
          searchedAlbums.removeAt(albumIndex);
          album.isFetched = true;
          searchedAlbums.insert(albumIndex, album);
        } else {
          return;
        }
      }
      if (albumCategory == AlbumCategory.recentlyPlayed) {
        Album album = getRecentlyPlayedAlbumsById(id);
        if (!album.isFetched) {
          final extractedList = await albumApi.fetchAlbumsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
          }
          album.tracks = loadedTracks;
          final albumIndex =
              _recentlyPlayed.indexWhere((album) => album.id == id);
          _recentlyPlayed.removeAt(albumIndex);
          album.isFetched = true;
          _recentlyPlayed.insert(albumIndex, album);
        } else {
          return;
        }
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  List<Track> getPlayableTracks(String id, AlbumCategory category) {
    print('playlist id:' + id);
    if (category == AlbumCategory.artist) {
      final index = artistAlbums.indexWhere((playlist) => playlist.id == id);
      return artistAlbums[index].tracks;
    } else if (category == AlbumCategory.mostRecentAlbums) {
      final index =
          _mostrecentAlbums.indexWhere((playlist) => playlist.id == id);
      return _mostrecentAlbums[index].tracks;
    } else if (category == AlbumCategory.myAlbums) {
      final index = _myAlbums.indexWhere((playlist) => playlist.id == id);
      return _myAlbums[index].tracks;
    } else if (category == AlbumCategory.popularAlbums) {
      final index = _popularAlbums.indexWhere((playlist) => playlist.id == id);
      return _popularAlbums[index].tracks;
    } else if (category == AlbumCategory.search) {
      final index = searchedAlbums.indexWhere((playlist) => playlist.id == id);
      return searchedAlbums[index].tracks;
    }
  }
}
