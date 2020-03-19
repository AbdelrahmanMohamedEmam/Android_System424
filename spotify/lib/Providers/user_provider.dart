import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/Models/http_exception.dart';
import '../Models/user.dart';
import '../Models/image.dart' as img;
import '../Models/user_stats.dart';
class UserProvider with ChangeNotifier {



  //SignUp and Login Attributes
  User _user;
  String _token;
  DateTime _expiryDate;
  Timer _authTimer;
  bool _status;



  //Facebook Login Attributes
  var facebookLogin = FacebookLogin();
  bool _isLoggedIn = false;
  Map userProfile;


  //Resetting Password Attributes
  bool resetSuccessful=false;


  //Constructor
  UserProvider();


  //UserInfo Getters
  bool isUserPremium() {
    print(_user.role);
    if(_user.role=='premium' || _user.role=='artist')
      {
       return true;
      }
    else{
      return false;
    }
  }

  bool isUserArtist(){
    if(_user.role=='artist'){
      return true;
    }
    return false;
  }

  String get userId {
    return _user.id;
  }

  String get username {
    return _user.name;
  }

  String get userEmail{
    return _user.email;
  }

  List<img.Image> get userImage{
    return _user.images;
  }

  UserStats get userStats{
    return _user.userStats;
  }

  String get resetPasswordToken{
    return _user.resetPasswordToken;
  }



  //UserInfo Setters
  void setPremium(String premium){
    _user.role='premium';
  }

  Future<void> setUser(String token) async {
    final url = 'http://www.mocky.io/v2/5e72794b330000b35444c94a';

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

      if (responseData['message'] != null) {

        throw HttpException(responseData['message']);

      } else {
        _user=User.fromJson(responseData);
        print(_user.id.toString());
        print(_user.password.toString());
        print(_user.email.toString());
        print(_user.name.toString());
        print(_user.externalUrl.toString());
        print(_user.gender.toString());
        print(_user.dateOfBirth.toString());
        print(_user.country.toString());
        print(_user.product);
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }
///////////////////////////////////////////////////


  bool get isResetSuccessful{
    return resetSuccessful;
  }


  bool get isLoginSuccessfully{
    return _status;
  }


  bool get isFbLogin{
    return _isLoggedIn;
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


  Future<String> signInWithFB() async{

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
          return profile['email'];
        break;

      case FacebookLoginStatus.cancelledByUser:
         _isLoggedIn = false;
         return 'FBLogin Failed';
        break;
      case FacebookLoginStatus.error:
        _isLoggedIn = false;
        return 'FBLogin Failed';
        break;
    }

  }




  Future<void> signUp(String email, String password,String gender,String username, String dateOfBirth)async {
    final url = 'http://www.mocky.io/v2/5e710a8130000086687a33e1';


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
                days: 1
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
        print('SignUpDone');
        prefs.setString('userData', userData);

      }

    } catch (error) {
      //print(error.toString());
      throw HttpException(error.toString());
    }
  }



  Future<void> signIn(String email, String password)async {
    final url = 'http://www.mocky.io/v2/5e710a8130000086687a33e1';

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
                days: 1
            ));
        print(responseData);
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
      print(error.toString());
      throw error;
    }
  }




  Future<void> forgetPassword(String email)async {
    final url = 'http://www.mocky.io/v2/5e710d6630000086687a33f8';


    try {
      final response = await http.post(url, body: jsonEncode({
        "email": email,
      },
      ),
      );

      final responseData = jsonDecode(response.body);


      if (responseData['status'] != 304) {

        throw HttpException(responseData['message']);

      }
      else{
        resetSuccessful=true;
        print(responseData['message']);
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
    print('token expires');
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    //notifyListeners();
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
