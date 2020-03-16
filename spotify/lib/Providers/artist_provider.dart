import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_provider.dart';
import '../Models/user_stats.dart';
import '../Models/user.dart';
import 'package:spotify/Models/http_exception.dart';

class Artist {
  final List albums;
  final List playlists;
  final List songs;
  final List suggesstedArtists;
  final String aboutInfo;
  final User userInfo;

  //*THESE ATTRIBUTES WILL BE LOADED FROM USER PROVIDER*//
  //final String id;
  //final String imageUrl;
  //final String username;
  //final bool isArtist;
 // final int noOfFollowers;


  Artist({
    this.albums ,
    this.playlists ,
    this.songs ,
    this.suggesstedArtists ,
    this.aboutInfo,
    this.userInfo,
  });
}

class ArtistProvider with ChangeNotifier {
  //Attributes
  Artist user;
  String authToken;

  //Constructor
  ArtistProvider();

  //Getters
  List get artistAlbums {
    return user.albums;
  }

  List get artistPlaylist {
    return user.playlists;
  }

  List get artistSongs {
    return user.songs;
  }

  List get artistSuggessted {
    return user.suggesstedArtists;
  }

  String get artistInfo {
    return user.aboutInfo;
  }

  //



  Future<void> setUser(String token) async {
    final url = '';

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "token": token,
          },
        ),
      );

      final responseData = jsonDecode(response.body);

      if (responseData['error'] != null) {

        throw HttpException(responseData['message']);

      } else {

        /*user=User(
          id:,
          imageUrl: ,
          isArtist: ,
          isPremium: ,
          noOfFollowers: ,
          noOfFollowings: ,
          username: ,
        );*/
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }
}
