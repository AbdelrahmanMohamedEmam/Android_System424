import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_provider.dart';
import '../Models/user_stats.dart';
import '../Models/user.dart';
import 'package:spotify/Models/http_exception.dart';
import '../Models/artist.dart';
import '../API_Providers/artistAPI.dart';

class ArtistProvider with ChangeNotifier {
  final String baseUrl;
  ArtistProvider({this.baseUrl});
  Artist _choosedArtist;
  List<Artist> _returnMultiple = [];
  List<Artist> _returnAll = [];

  Artist get getChoosedArtist  {
     return  _choosedArtist;
  }

  List<Artist> get getMultipleArtists {
    return [..._returnMultiple];
  }
///getter for all artists for sign up
  List<Artist> get getAllArtists {
    return [..._returnAll];
  }

  Future<void> fetchChoosedArtist(String token , String id) async {
    //const url = 'http://www.mocky.io/v2/5e838e2b3000003a31cf3f05';
    ArtistAPI artistsApi = ArtistAPI(baseUrl: baseUrl);
    try {
      Artist extractedArtist = await artistsApi.fetchChosenApi(token, id);
      _choosedArtist = extractedArtist;
    }catch (error)
    {
      throw HttpException(error.toString());
    }
  }

  Future<void> fetchMultipleArtists(String token , String id) async {
    ArtistAPI artistsApi = ArtistAPI(baseUrl: baseUrl);
    try {
      final extractedList = await artistsApi.fetchMultiApi(token , id);
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

  ///function to get all artists for the 1st sign up
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
