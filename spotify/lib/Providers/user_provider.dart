import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String id;
  final String username;
  final bool isPremium;
  final bool isArtist;
  final int noOfFollowers;
  final int noOfFollowings;

  User({
    this.id,
    this.isArtist,
    this.isPremium,
    this.noOfFollowers,
    this.noOfFollowings,
    this.username,
  });
}

class UserProvider with ChangeNotifier {
  //Attributes
  User user;
  final String authToken;

  //Constructor
  UserProvider(this.authToken);

  //Getters
  bool get isUserPremium {
    return user.isPremium;
  }

  bool get isUserArtist {
    return user.isArtist;
  }

  String get userId {
    return user.id;
  }

  String get username {
    return user.username;
  }

  int get userFollowersNumber {
    return user.noOfFollowers;
  }

  int get userFollowingNumber {
    return user.noOfFollowings;
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
        //Handle Error

      } else {
        /*user=User(

                id:responseData['id'],
                username: responseData['name'],
                 );*/
        notifyListeners();
      }
    } catch (error) {
      //throw error;
    }
  }
}
