///Importing flutter material to use it's libraries.
import 'package:flutter/material.dart';

///Importing an API from facebook to use facebook login.
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

///Importing library to send http requests.
import 'dart:convert';
import 'dart:async';

///Importing shared preference library to cache data.
import 'package:shared_preferences/shared_preferences.dart';

///Importing models to create objects.
import '../Models/user.dart';
import '../Models/image.dart' as img;
import '../Models/user_stats.dart';
import 'package:spotify/Models/http_exception.dart';
import '../API_Providers/userAPI.dart';

///This class provides the data of the user to the whole application.
///Provides the username, password, token, if he is premium or not, etc.
///It is responsible to do authentication functions such as sign up, login, etc.
///It is responsible to cache the data of the user to auto login him.
class UserProvider with ChangeNotifier {
  final String baseUrl;

  UserProvider({this.baseUrl});

  ///SignUp and Login Attributes.
  ///
  ///An object of [User] that contains the current user details.
  User _user;

  ///Contains the token of the user.
  String _token;

  ///Contains the expiry date of the token.
  DateTime _expiryDate;

  ///A countdown to the expiry time.
  Timer _authTimer;

  ///Indicates if the user signed up/logged in successfully.
  bool _status;

  ///Facebook Login Attributes.
  ///
  ///An object of facebook plugin.
  var facebookLogin = FacebookLogin(
  );

  ///Indicates if the user logs in with facebook.
  bool _isLoggedInWithFB = false;

  ///Indicates if resetting password succeeded .
  bool resetSuccessful = false;

  bool followSuccessful = false;


  ///Returns true if the user is a premium user.
  bool isUserPremium() {
    print(
        _user.role);
    if (_user.role == 'premium' || _user.role == 'artist') {
      return true;
    } else {
      return false;
    }
  }

  ///Returns true if the user is an artist.
  bool isUserArtist() {
    if (_user.role == 'artist') {
      return true;
    }
    return false;
  }

  ///Returns the user's id.
  String get userId {
    return _user.id;
  }

  ///Returns the user's username.
  String get username {
    return _user.name;
  }

  ///Returns the user's email.
  String get userEmail {
    return _user.email;
  }

  ///Returns the user's images.
  List<img.Image> get userImage {
    return _user.images;
  }

  ///Returns the user's stats.
  UserStats get userStats {
    return _user.userStats;
  }

  ///Returns the user's reset password token.
  String get resetPasswordToken {
    return _user.resetPasswordToken;
  }


  ///Setting the user to a premium/free user.
  void setPremium(String premium) {
    _user.role = premium;
  }

  ///Initializing the user data after signing up/ logging in.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> setUser(String token) async {
    UserAPI userAPI = UserAPI(
        baseUrl: baseUrl);

    try {
      _user = await userAPI.setUser(
          _token);
      print(
          _user.email);
    } catch (error) {
      print(
          error.toString(
          ));
      throw HttpException(
          error.toString(
          ));
    }
  }

  ///Returns true if reset password request is successful.
  bool get isResetSuccessful {
    return resetSuccessful;
  }

  ///Return true if the login request is successful.
  bool get isLoginSuccessfully {
    return _status;
  }

  ///Returns true if the user logged in with facebook.
  bool get isFbLogin {
    return _isLoggedInWithFB;
  }


  /// Returns true if the user is authenticated.
  bool get isAuth {
    return token != null;
  }

  ///Returns the token of the user.
  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  ///Sends a http request to signIn/signUp with facebook account.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> signInWithFB() async {
    UserAPI userAPI = UserAPI(
        baseUrl: baseUrl);

    try {
      final responseData = await userAPI.signInWithFB(
      );

      if (responseData['message'] != null) {
        throw HttpException(
            responseData['message']);
      } else {
        _isLoggedInWithFB = true;
        _token = responseData['token'];
        _status = responseData['success'];
        print(
            _token.toString(
            ));
        _expiryDate = DateTime.now(
        ).add(
            Duration(
                days: 1));
        _autoLogout(
        );
        notifyListeners(
        );
        final prefs = await SharedPreferences.getInstance(
        );
        final userData = json.encode(
          {
            'token': _token,
            'expiryDate': _expiryDate.toIso8601String(
            ),
          },
        );
        print(
            'FacebookLoginDone');
        prefs.setString(
            'userData', userData);
      }
    } catch (error) {
      _isLoggedInWithFB = false;
      throw HttpException(
          error.toString(
          ));
    }
  }

  ///Sends a request to signUp a new user.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> signUp(String email, String password, String gender,
      String username, String dateOfBirth) async {
    UserAPI userAPI = UserAPI(
        baseUrl: baseUrl);
    try {
      final responseData =
      await userAPI.signUp(
          email, password, gender, username, dateOfBirth);

      if (responseData['message'] != null) {
        throw HttpException(
            responseData['message']);
      } else {
        _token = responseData['token'];
        _status = responseData['success'];
        print(
            _token.toString(
            ));
        _expiryDate = DateTime.now(
        ).add(
            Duration(
                days: 1));
        _autoLogout(
        );
        notifyListeners(
        );
        final prefs = await SharedPreferences.getInstance(
        );
        final userData = json.encode(
          {
            'token': _token,
            'expiryDate': _expiryDate.toIso8601String(
            ),
          },
        );
        print(
            responseData);
        print(
            'SignUpDone');
        prefs.setString(
            'userData', userData);
      }
    } catch (error) {
      throw HttpException(
          error.toString(
          ));
    }
  }

  ///Sends a http request to sign in a user.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> signIn(String email, String password) async {
    UserAPI userAPI = UserAPI(
        baseUrl: baseUrl);

    try {
      final responseData = await userAPI.signIn(
          email, password);
      if (responseData['message'] != null) {
        throw HttpException(
            responseData['message']);
      } else {
        _token = responseData['token'];
        _status = responseData['success'];
        _expiryDate = DateTime.now(
        ).add(
            Duration(
                days: 1));
        _autoLogout(
        );
        notifyListeners(
        );
        print(
            responseData);
        final prefs = await SharedPreferences.getInstance(
        );
        final userData = json.encode(
          {
            'token': _token,
            'expiryDate': _expiryDate.toIso8601String(
            ),
          },
        );
        prefs.setString(
            'userData', userData);
      }
    } catch (error) {
      print(
          error.toString(
          ));
      throw error;
    }
  }

  ///Sends a request to send an email to create a new password.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> forgetPassword(String email) async {
    UserAPI userAPI = UserAPI(
        baseUrl: baseUrl);

    try {
      bool succeeded = await userAPI.forgetPassword(
          email);

      if (!succeeded) {
        print(
            'failed');
        throw HttpException(
            'Couldn\'t reset your password. Please try again later');
      } else {
        print(
            'succeeded');
        resetSuccessful = true;
      }
      notifyListeners(
      );
    } catch (error) {
      print(
          error.toString(
          ));
      throw error;
    }
  }

  ///Checks if the token cached is valid or not to autologin the user.
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance(
    );
    if (!prefs.containsKey(
        'userData')) {
      return false;
    }
    final extractedUserData =
    json.decode(
        prefs.getString(
            'userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(
        extractedUserData['expiryDate']);

    if (expiryDate.isBefore(
        DateTime.now(
        ))) {
      return false;
    }
    _token = extractedUserData['token'];
    _expiryDate = expiryDate;
    await setUser(
        _token);
    notifyListeners(
    );
    _autoLogout(
    );
    return true;
  }


  ///Nullify the data of the user to log him out.
  Future<void> logout() async {
    _token = null;
    _status = null;
    _expiryDate = null;
    _user = null;
    _isLoggedInWithFB = null;
    _authTimer = null;
    print(
        'token expires');
    if (_authTimer != null) {
      _authTimer.cancel(
      );
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance(
    );
    prefs.clear(
    );
    notifyListeners(
    );
  }

  ///Nullify the user automatically and reset the timer to log him out.
  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel(
      );
    }
    final timeToExpiry = _expiryDate
        .difference(
        DateTime.now(
        ))
        .inSeconds;
    _authTimer = Timer(
        Duration(
            seconds: timeToExpiry), logout);
  }


  ///Sends a http request to upgrade a user to premium.
  ///An object from the API provider [UserAPI] to send requests is created.
  Future<void> upgradePremium(String confirmationCode) async {
    UserAPI userAPI = UserAPI(
        baseUrl: baseUrl);
    try {
      final responseData = await userAPI.upgradePremium(
          confirmationCode, token);
      if (responseData == true) {
        setPremium(
            'premium');
        return;
      }
    } catch (error) {
      print(
          error.toString(
          ));
      throw error;
    }
  }


  ///Sends a http request to send an email with a confirmation code to be a premium user.
  ///An object from the API provider [UserAPI] to send requests is created.
  Future<void> askForPremium() async {
    UserAPI userAPI = UserAPI(
        baseUrl: baseUrl);
    try {
      await userAPI.askForPremium(
          token);
    } catch (error) {
      print(
          error.toString(
          ));
      throw error;
    }
  }

  Future<void> follow(String id) async {
    UserAPI userAPI = UserAPI(
        baseUrl: baseUrl);
    try {
      bool succeeded = await userAPI.followArtist(
          token, id);
      if (!succeeded) {
        print(
            'failed');
        throw HttpException(
            'Couldn\'t reset your password. Please try again later');
      } else {
        print(
            'succeeded');
        followSuccessful = true;
      }
      notifyListeners(
      );
    } catch (error) {
      print(
          error.toString(
          ));
      throw error;
    }
  }
}