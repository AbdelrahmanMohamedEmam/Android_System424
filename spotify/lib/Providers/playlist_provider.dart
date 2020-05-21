//Importing libraries from external packages.
import 'package:flutter/foundation.dart';

//Import providers.
import 'package:spotify/API_Providers/playlistAPI.dart';

//Import Models.
import '../Models/playlist.dart';
import 'package:spotify/Models/http_exception.dart';
import 'package:spotify/Models/track.dart';

///Enum for Identification for the playistcategory.
enum PlaylistCategory {
  popularPlaylists,
  mostRecentPlaylists,
  jazz,
  happy,
  arabic,
  pop,
  artist,
}

///Class PlaylistProvider.
class PlaylistProvider with ChangeNotifier {
  final String baseUrl;
  PlaylistProvider({this.baseUrl});

  ///List of playlist objects categorized as most recent playlists.
  List<Playlist> _mostRecentPlaylists = [];

  ///List of playlist objects categorized as popular playlists.
  List<Playlist> _popularPlaylists = [];

  ///List of playlist objects categorized as artist profile playlists.
  List<Playlist> _artistProfilePlaylists = [];

  ///List of playlist objects categorized as pop playlists.
  List<Playlist> _popPlaylists = [];

  ///List of playlist objects categorized as jazz playlists.
  List<Playlist> _jazzPlaylists = [];

  ///List of playlist objects categorized as arabic playlists.
  List<Playlist> _arabicPlaylists = [];

  ///List of playlist objects categorized as happy playlists.
  List<Playlist> _happyPlaylists = [];

  ///A method(getter) that returns a list of playlists (most Recent Playlists).
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

  ///A method(getter) that returns a list of playlists (pop playlists).
  List<Playlist> get getpopPlaylists {
    return [..._popPlaylists];
  }

  ///A method(getter) that returns a list of playlists (jazz playlists).
  List<Playlist> get getJazzPlaylists {
    return [..._jazzPlaylists];
  }

  ///A method(getter) that returns a list of playlists (arabic playlists).
  List<Playlist> get getArabicPlaylists {
    return [..._arabicPlaylists];
  }

  ///A method(getter) that returns a list of playlists (happy playlists).
  List<Playlist> get getHappyPlaylists {
    return [..._happyPlaylists];
  }

  ///A method that returns a most recent playlist from mostRecentPlaylists list.
  ///It takes a [String] id.
  Playlist getMostRecentPlaylistsId(String id) {
    final playlistIndex =
        _mostRecentPlaylists.indexWhere((playlist) => playlist.id == id);
    return _mostRecentPlaylists[playlistIndex];
  }

  ///A method that returns a most popular playlist from popular Playlists list.
  ///It takes a [String] id.
  Playlist getPopularPlaylistsId(String id) {
    final playlistIndex =
        _popularPlaylists.indexWhere((playlist) => playlist.id == id);
    return _popularPlaylists[playlistIndex];
  }

  ///A method that returns a jazz playlist from jazz Playlists list.
  ///It takes a [String] id.
  Playlist getJazzPlaylistsId(String id) {
    final playlistIndex =
        _jazzPlaylists.indexWhere((playlist) => playlist.id == id);
    return _jazzPlaylists[playlistIndex];
  }

  ///A method that returns a happy playlist from happy Playlists list.
  ///It takes a [String] id.
  Playlist getHappyPlaylistsId(String id) {
    final playlistIndex =
        _happyPlaylists.indexWhere((playlist) => playlist.id == id);
    return _happyPlaylists[playlistIndex];
  }

  ///A method that returns a arabic playlist from arabic Playlists list.
  ///It takes a [String] id.
  Playlist getArabicPlaylistsId(String id) {
    final playlistIndex =
        _arabicPlaylists.indexWhere((playlist) => playlist.id == id);
    return _arabicPlaylists[playlistIndex];
  }

  ///A method that returns a arabic playlist from arabic Playlists list.
  ///It takes a [String] id.
  Playlist getPopPlaylistsId(String id) {
    final playlistIndex =
        _popPlaylists.indexWhere((playlist) => playlist.id == id);
    return _popPlaylists[playlistIndex];
  }

  ///A method that returns a arabic playlist from arabic Playlists list.
  ///It takes a [String] id.
  Playlist getArtistPlaylistsbyId(String id) {
    final playlistIndex =
        _artistProfilePlaylists.indexWhere((playlist) => playlist.id == id);
    return _artistProfilePlaylists[playlistIndex];
  }

  ///A method that emty the lists.
  void emptyLists() {
    _popPlaylists = [];
    _popularPlaylists = [];
    _mostRecentPlaylists = [];
  }

  ///A method that fetches for made for you playlists and set them in the made for you list.
  ///It takes a [String] token for verification.
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
  ///It takes a [String] token for verification.
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
  ///It takes a [String] token for verificationand id for this category.
  Future<void> fetchPopPlaylists(String token, String id) async {
    PlaylistAPI playlistApi = PlaylistAPI(baseUrl: baseUrl);
    try {
      final extractedList = await playlistApi.fetchPopPlaylistsApi(token, id);

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
  ///It takes a [String] token for verificationand id for this category.
  Future<void> fetchJazzPlaylists(String token, String id) async {
    PlaylistAPI playlistApi = PlaylistAPI(baseUrl: baseUrl);
    try {
      final extractedList = await playlistApi.fetchJazzPlaylistsApi(token, id);

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

  ///A method that fetches for workout playlists and set them in the workout list.
  ///It takes a [String] token for verificationand id for this category.
  Future<void> fetchArabicPlaylists(String token, String id) async {
    PlaylistAPI playlistApi = PlaylistAPI(baseUrl: baseUrl);
    try {
      final extractedList =
          await playlistApi.fetchArabicPlaylistsApi(token, id);

      final List<Playlist> loadedPlaylists = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
      }
      _arabicPlaylists = loadedPlaylists;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches for workout playlists and set them in the workout list.
  ///It takes a [String] token for verificationand id for this category.
  Future<void> fetchHappyPlaylists(String token, String id) async {
    PlaylistAPI playlistApi = PlaylistAPI(baseUrl: baseUrl);
    try {
      final extractedList = await playlistApi.fetchHappyPlaylistsApi(token, id);

      final List<Playlist> loadedPlaylists = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
      }
      _happyPlaylists = loadedPlaylists;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches for artist profile playlists and set them in the artist profle list.
  ///It takes a [String] token for verificationand id for this category.
  Future<void> fetchArtistProfilePlaylists(String token, String id) async {
    PlaylistAPI playlistApi = PlaylistAPI(baseUrl: baseUrl);
    try {
      final extractedList =
          await playlistApi.fetchArtistPlaylistsApi(token, id);

      final List<Playlist> loadedPlaylists = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedPlaylists.add(Playlist.fromJson(extractedList[i]));
      }
      _artistProfilePlaylists = loadedPlaylists;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches tracks for a certain playlist in a certain playlist by id and [PlaylistCategory].
  ///It takes [String] token for verification and id to identify the playlist to add tracks to and [PlaylistCategory] to know which playlist to select from.
  Future<void> fetchPlaylistsTracksById(
      String id, String token, PlaylistCategory playlistCategory) async {
    PlaylistAPI playlistApi = PlaylistAPI(baseUrl: baseUrl);
    try {
      final List<Track> loadedTracks = [];
      if (playlistCategory == PlaylistCategory.mostRecentPlaylists) {
        Playlist playlist = getMostRecentPlaylistsId(id);
        if (!playlist.isFetched) {
          final extractedList =
              await playlistApi.fetchPlaylistsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
          }
          playlist.tracks = loadedTracks;
          final playlistIndex =
              _mostRecentPlaylists.indexWhere((playlist) => playlist.id == id);
          _mostRecentPlaylists.removeAt(playlistIndex);
          playlist.isFetched = true;
          _mostRecentPlaylists.insert(playlistIndex, playlist);
        } else {
          return;
        }
      }

      if (playlistCategory == PlaylistCategory.popularPlaylists) {
        Playlist playlist = getPopularPlaylistsId(id);
        if (!playlist.isFetched) {
          final extractedList =
              await playlistApi.fetchPlaylistsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
          }
          playlist.tracks = loadedTracks;
          final playlistIndex =
              _popularPlaylists.indexWhere((playlist) => playlist.id == id);
          _popularPlaylists.removeAt(playlistIndex);
          playlist.isFetched = true;
          _popularPlaylists.insert(playlistIndex, playlist);
        } else {
          return;
        }
      }

      if (playlistCategory == PlaylistCategory.jazz) {
        Playlist playlist = getJazzPlaylistsId(id);
        if (!playlist.isFetched) {
          final extractedList =
              await playlistApi.fetchPlaylistsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
          }
          playlist.tracks = loadedTracks;
          final playlistIndex =
              _jazzPlaylists.indexWhere((playlist) => playlist.id == id);
          _jazzPlaylists.removeAt(playlistIndex);
          playlist.isFetched = true;
          _jazzPlaylists.insert(playlistIndex, playlist);
        } else {
          return;
        }
      }

      if (playlistCategory == PlaylistCategory.happy) {
        Playlist playlist = getHappyPlaylistsId(id);
        if (!playlist.isFetched) {
          final extractedList =
              await playlistApi.fetchPlaylistsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
          }
          playlist.tracks = loadedTracks;
          final playlistIndex =
              _happyPlaylists.indexWhere((playlist) => playlist.id == id);
          _happyPlaylists.removeAt(playlistIndex);
          playlist.isFetched = true;
          _happyPlaylists.insert(playlistIndex, playlist);
        } else {
          return;
        }
      }

      if (playlistCategory == PlaylistCategory.arabic) {
        Playlist playlist = getArabicPlaylistsId(id);
        if (!playlist.isFetched) {
          final extractedList =
              await playlistApi.fetchPlaylistsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
          }
          playlist.tracks = loadedTracks;
          final playlistIndex =
              _arabicPlaylists.indexWhere((playlist) => playlist.id == id);
          _arabicPlaylists.removeAt(playlistIndex);
          playlist.isFetched = true;
          _arabicPlaylists.insert(playlistIndex, playlist);
        } else {
          return;
        }
      }

      if (playlistCategory == PlaylistCategory.pop) {
        Playlist playlist = getPopPlaylistsId(id);
        if (!playlist.isFetched) {
          final extractedList =
              await playlistApi.fetchPlaylistsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
          }
          playlist.tracks = loadedTracks;
          final playlistIndex =
              _popPlaylists.indexWhere((playlist) => playlist.id == id);
          _popPlaylists.removeAt(playlistIndex);
          playlist.isFetched = true;
          _popPlaylists.insert(playlistIndex, playlist);
        } else {
          return;
        }
      }

      if (playlistCategory == PlaylistCategory.artist) {
        Playlist playlist = getPopPlaylistsId(id);
        if (!playlist.isFetched) {
          final extractedList =
              await playlistApi.fetchPlaylistsTracksApi(token, id);
          for (int i = 0; i < extractedList.length; i++) {
            loadedTracks.add(Track.fromJson(extractedList[i]));
          }
          playlist.tracks = loadedTracks;
          final playlistIndex = _artistProfilePlaylists
              .indexWhere((playlist) => playlist.id == id);
          _artistProfilePlaylists.removeAt(playlistIndex);
          playlist.isFetched = true;
          _artistProfilePlaylists.insert(playlistIndex, playlist);
        } else {
          return;
        }
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  List<Track> getPlayableTracks(String id, PlaylistCategory category){
    print('playlist id:' + id);
    if(category==PlaylistCategory.arabic){
      final index=_arabicPlaylists.indexWhere((playlist)=>playlist.id==id);
      return _arabicPlaylists[index].tracks;
    }
    else if(category==PlaylistCategory.artist){
      final index=_artistProfilePlaylists.indexWhere((playlist)=>playlist.id==id);
      return _artistProfilePlaylists[index].tracks;
    }
    else if(category==PlaylistCategory.pop){
      final index=_popPlaylists.indexWhere((playlist)=>playlist.id==id);
      return _popPlaylists[index].tracks;
    }
    else if(category==PlaylistCategory.happy){
      final index=_happyPlaylists.indexWhere((playlist)=>playlist.id==id);
      return _happyPlaylists[index].tracks;
    }
    else if(category==PlaylistCategory.jazz){
      final index=_jazzPlaylists.indexWhere((playlist)=>playlist.id==id);
      return _jazzPlaylists[index].tracks;
    }
    else if(category==PlaylistCategory.mostRecentPlaylists){
      final index=_mostRecentPlaylists.indexWhere((playlist)=>playlist.id==id);
      return _mostRecentPlaylists[index].tracks;
    }
    else if(category==PlaylistCategory.popularPlaylists){
      final index=_popularPlaylists.indexWhere((playlist)=>playlist.id==id);
      return _popularPlaylists[index].tracks;
    }
  }
}
