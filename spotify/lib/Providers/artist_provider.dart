import 'package:flutter/material.dart';
import 'package:spotify/Models/http_exception.dart';
import '../Models/artist.dart';
import '../API_Providers/artistAPI.dart';

///Class [ArtistProvider] which is used to provide artist info to all widgets.
class ArtistProvider with ChangeNotifier {
  /// Indicator tom set the [baseUrl] to know which source will data be loaded from.
  /// mock source or the original database [required] parameter.
  final String baseUrl;

  ///Constructor to set then baseUrl
  ArtistProvider({this.baseUrl});

  ///returns Artist object with all artist info for a certain artist by ID.
  Artist _chosenArtist;

  ///List of artist objects which is related to certain artist.
  List<Artist> _returnMultiple = [];

  ///List of artist objects which appear to the user to choose from at his first sign-up.
  List<Artist> _returnAll = [];

  ///getter for [_chosenArtist] member of artist provider.
  Artist get getChosenArtist {
    return _chosenArtist;
  }

  ///getter for [_returnMultiple] member of artist provider.
  List<Artist> get getMultipleArtists {
    return [..._returnMultiple];
  }

  ///getter for [_returnAll] member of artist provider.
  List<Artist> get getAllArtists {
    return [..._returnAll];
  }

  ///A method that fetches info of certain artist by id.
  Future<void> fetchChoosedArtist(String token, String id) async {
    ArtistAPI artistsApi = ArtistAPI(baseUrl: baseUrl);
    try {
      Artist extractedArtist = await artistsApi.fetchChosenApi(token, id);
      _chosenArtist = extractedArtist;
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches list of artists related to certain artist.
  Future<void> fetchMultipleArtists(String token, String id) async {
    ArtistAPI artistsApi = ArtistAPI(baseUrl: baseUrl);
    try {
      final extractedList = await artistsApi.fetchMultiApi(token, id);
      final List<Artist> loadedArtist = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedArtist.add(Artist.fromJson(extractedList[i]));
      }
      _returnMultiple = loadedArtist;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///a method that get all artists for the 1st sign up
  Future<void> fetchAllArtists(String token) async {
    ArtistAPI artistsApi = ArtistAPI(baseUrl: baseUrl);
    try {
      final extractedList = await artistsApi.fetchAllApi(token);
      final List<Artist> loadedArtist = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedArtist.add(Artist.fromJson(extractedList[i]));
      }
      _returnAll = loadedArtist;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
