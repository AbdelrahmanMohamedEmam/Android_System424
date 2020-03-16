import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/Models/http_exception.dart';
import '../Models/user.dart';
class UserProvider with ChangeNotifier {
  //Attributes
  User user;
  String _token;
  DateTime _expiryDate;
  Timer _authTimer;


  bool _status;
  var facebookLogin = FacebookLogin();
  bool _isLoggedIn = false;
  Map userProfile;

  //Constructor
  UserProvider();

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

 /* int get userFollowersNumber {
    return user.noOfFollowers;
  }

  int get userFollowingNumber {
    return user.noOfFollowings;
  }*/

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


  //AUTHENTICATION SECTION

  bool get isAuth{
    //notifyListeners();
    return token !=null;

  }

  String get token{
    if (_token!=null){
      return _token;
    }
    return null;
  }




  signInWithFB() async{

    final result = await facebookLogin.logInWithReadPermissions(['email']);


    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token='+token);
        final profile = jsonDecode(graphResponse.body);
        print(profile.toString());
        print(token);
          userProfile = profile;
          _isLoggedIn = true;
        break;

      case FacebookLoginStatus.cancelledByUser:
         _isLoggedIn = false;
        break;
      case FacebookLoginStatus.error:
        _isLoggedIn = false;
        break;
    }

  }




  Future<void> signUp(String email, String password,String gender,String username, String dateOfBirth)async {
    final url = 'http://www.mocky.io/v2/5e6d1ee72e000057000eeb40';


    try {
      final response = await http.post(url, body: jsonEncode({
        "email": email,
        "password": password,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "username": username,
      },
      ),
      );

      final responseData = jsonDecode(response.body);


      if (responseData['message'] != null) {

        throw HttpException(responseData['message']);

      }
      else{
        _token = responseData['token'];
        _status= responseData['success'];
        print(_token.toString());
        _expiryDate = DateTime.now().add(
            Duration(
                hours: 12
            ));
        _autoLogout();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
            'expiryDate': _expiryDate.toIso8601String(),
          },
        );
        prefs.setString('userData', userData);

      }

    } catch (error) {
      //print(error.toString());
      throw HttpException(error.toString());
    }
  }



  Future<void> signIn(String email, String password)async {
    final url = 'http://www.mocky.io/v2/5e6d364c2e00005d000eeb7c';


    try {
      final response = await http.post(url, body: jsonEncode({
        "email": email,
        "password": password,
      },
      ),
      );

      final responseData = jsonDecode(response.body);


      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      }
      else{
        _token = responseData['token'];
        _status= responseData['success'];
        _expiryDate = DateTime.now().add(
            Duration(
                hours: 12
            ));
        _autoLogout();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
            'expiryDate': _expiryDate.toIso8601String(),
          },
        );
        prefs.setString('userData', userData);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }




  Future<void> forgetPassword(String email)async {
    final url = '';


    try {
      final response = await http.post(url, body: jsonEncode({
        "email": email,
      },
      ),
      );

      final responseData = jsonDecode(response.body);


      if (responseData['error'] != null) {

        throw HttpException(responseData['message']);

      }
      else{


      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }



  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      //notifyListeners();
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }




  Future<void> logout() async {
    _token = null;
    _status=null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }




  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

}
