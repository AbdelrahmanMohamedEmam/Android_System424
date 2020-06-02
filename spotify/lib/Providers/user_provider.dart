import 'dart:io';

///Importing flutter material to use it's libraries.
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

///Importing an API from facebook to use facebook login.
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_test/flutter_test.dart';

///Importing library to send http requests.
import 'dart:convert';
import 'dart:async';

///Importing shared preference library to cache data.
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/Models/artist.dart';
import 'package:spotify/Models/playlist.dart';

///Importing models to create objects.
import '../Models/user.dart';
import '../Models/user_stats.dart';
import 'package:spotify/Models/http_exception.dart';
import '../API_Providers/userAPI.dart';

///This class provides the data of the user to the whole application.
///Provides the username, password, token, if he is premium or not, etc.
///It is responsible to do authentication functions such as sign up, login, etc.
///It is responsible to cache the data of the user to auto login him.
class UserProvider with ChangeNotifier {
  final String baseUrl;
  final BuildContext context;

  UserProvider({this.baseUrl, this.context});

  ///SignUp and Login Attributes.
  ///
  ///An object of [User] that contains the current user details.
  User _user;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  ///Contains the token of the user.
  String _token;

  ///Contains the token of the user.
  String _firebaseToken;

  ///Contains the expiry date of the token.
  DateTime _expiryDate;

  ///A countdown to the expiry time.
  Timer _authTimer;

  ///Indicates if the user signed up/logged in successfully.
  bool _status;

  ///Facebook Login Attributes.
  ///
  ///An object of facebook plugin.
  var facebookLogin = FacebookLogin();

  ///Indicates if the user logs in with facebook.
  bool _isLoggedInWithFB = false;

  ///Indicates if resetting password succeeded .
  bool resetSuccessful = false;

  bool followSuccessful = false;

  ///List of the following users.
  List<User> followingUsers = [];

  ///List of the followers users.
  List<User> followersUsers = [];

  ///List of the followeing artists.
  List<Artist> followedArtists;

  ///Returns true if the user is a premium user.
  bool isUserPremium() {
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

  ///Returns the users id.
  String get userId {
    return _user.id;
  }

  ///Returns the users username.
  String get username {
    return _user.name;
  }

  ///Returns the users email.
  String get userEmail {
    return _user.email;
  }

  ///Returns the users images.
  List<String> get userImage {
    return _user.images;
  }

  ///Returns the users stats.
  List<UserStats> get userStats {
    return _user.userStats;
  }

  ///Returns the users reset password token.
  String get resetPasswordToken {
    return _user.resetPasswordToken;
  }

  ///Returns the users gender.
  String get userGender {
    return _user.gender;
  }

  ///Returns the users gender.
  String get userDateOfBirth {
    return _user.dateOfBirth;
  }

  ///Setter to the pickedImage File.
  void setUserPickedImage(File pickedImage) {
    _user.pickedImage = pickedImage;
  }

  File get getpickedImage {
    return _user.pickedImage;
  }

  ///Setting the user to a premium/free user.
  void setPremium(String premium) {
    _user.role = premium;
  }

  List<String> get getfollowers {
    return _user.followers;
  }

  List<String> get getfollowing {
    return _user.following;
  }

  List<Artist> get getFollowedArtists {
    return followedArtists;
  }

  List<User> get getfollowersUsers {
    return followersUsers;
  }

  List<User> get getfollowingUsers {
    return followingUsers;
  }

  ///Initializing the user data after signing up/ logging in.
  ///Token must be provided for authentication.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> setUser(String token) async {
    UserAPI userAPI = UserAPI(baseUrl: baseUrl);

    try {
      _user = await userAPI.setUser(_token);
      _user.firebaseToken = _firebaseToken;
    } catch (error) {
      throw HttpException(error.toString());
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
  ///In case of success the expiry date is calculated and cached along with the token.
  Future<void> signInWithFB() async {
    UserAPI userAPI = UserAPI(baseUrl: baseUrl);

    try {
      final responseData = await userAPI.signInWithFB();

      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      } else {
        _isLoggedInWithFB = true;
        _token = responseData['token'];
        _status = responseData['success'];
        String expiryDuration = responseData['expireDate'];
        Duration expireAfter;
        if (expiryDuration.endsWith('d')) {
          int index = expiryDuration.indexOf('d');
          expiryDuration = expiryDuration.substring(0, index);
          expireAfter = Duration(days: int.parse(expiryDuration));
        } else if (expiryDuration.endsWith('s')) {
          int index = expiryDuration.indexOf(' ');
          expiryDuration = expiryDuration.substring(0, index);
          expireAfter = Duration(minutes: int.parse(expiryDuration));
        }
        _expiryDate = DateTime.now().add(expireAfter);
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
      _isLoggedInWithFB = false;
      throw HttpException(error.toString());
    }
  }

  ///Sends a request to signUp a new user.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///In case of success the expiry date is calculated and cached along with the token.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> signUp(String email, String password, String gender,
      String username, String dateOfBirth) async {
    UserAPI userAPI = UserAPI(baseUrl: baseUrl);
    try {
      final responseData =
          await userAPI.signUp(email, password, gender, username, dateOfBirth);

      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      } else {
        final firebaseToken = await _firebaseMessaging.getToken();
        _firebaseToken = firebaseToken;

        _token = responseData['token'];
        _status = responseData['success'];
        String expiryDuration = responseData['expireDate'];
        Duration expireAfter;

        await updateFirebaseToken(_token, firebaseToken);

        if (expiryDuration.endsWith('d')) {
          int index = expiryDuration.indexOf('d');
          expiryDuration = expiryDuration.substring(0, index);
          expireAfter = Duration(days: int.parse(expiryDuration));
        } else if (expiryDuration.endsWith('s')) {
          int index = expiryDuration.indexOf(' ');

          expiryDuration = expiryDuration.substring(0, index);
          expireAfter = Duration(minutes: int.parse(expiryDuration));
        }

        _expiryDate = DateTime.now().add(expireAfter);
        _autoLogout();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
            'expiryDate': _expiryDate.toIso8601String(),
            'firebaseToken': firebaseToken
          },
        );
        prefs.setString('userData', userData);
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///Sends a http request to sign in a user.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///In case of success the expiry date is calculated and cached along with the token.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> signIn(String email, String password) async {
    UserAPI userAPI = UserAPI(baseUrl: baseUrl);

    try {
      final responseData = await userAPI.signIn(email, password);
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      } else {
        final firebaseToken = await _firebaseMessaging.getToken();

        _firebaseToken = firebaseToken;
        _token = responseData['token'];
        _status = responseData['success'];
        String expiryDuration = responseData['expireDate'];
        Duration expireAfter;

        await updateFirebaseToken(_token, firebaseToken);

        if (expiryDuration.endsWith('d')) {
          int index = expiryDuration.indexOf('d');
          expiryDuration = expiryDuration.substring(0, index);
          expireAfter = Duration(days: int.parse(expiryDuration));
        } else if (expiryDuration.endsWith('s')) {
          int index = expiryDuration.indexOf(' ');
          expiryDuration = expiryDuration.substring(0, index);
          expireAfter = Duration(minutes: int.parse(expiryDuration));
        }

        _expiryDate = DateTime.now().add(expireAfter);
        _autoLogout();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
            'expiryDate': _expiryDate.toIso8601String(),
            'firebaseToken': firebaseToken
          },
        );
        prefs.setString('userData', userData);
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  ///Sends a request to send an email to create a new password.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> forgetPassword(String email) async {
    UserAPI userAPI = UserAPI(baseUrl: baseUrl);

    try {
      bool succeeded = await userAPI.forgetPassword(email);

      if (!succeeded) {
        throw HttpException(
            'Couldn\'t reset your password. Please try again later');
      } else {
        resetSuccessful = true;
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  ///Checks if the token cached is valid or not to autologin the user.
  ///Try reading the token and exprity date from the cached data.
  ///In case of success in reading the data, the expiry date of the token is checked.
  ///Returns true if user it authenticated.
  ///Returns false if the user isn't allowed to access the app.
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _expiryDate = expiryDate;
    _firebaseToken = extractedUserData['firebaseToken'];

    final newFirebaseToken = await _firebaseMessaging.getToken();
    print("Fire base token" + _firebaseToken);
    if (newFirebaseToken != _firebaseToken) {
      _firebaseToken = newFirebaseToken;
      await updateFirebaseToken(_token, newFirebaseToken);
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'expiryDate': _expiryDate.toIso8601String(),
          'firebaseToken': newFirebaseToken
        },
      );
      prefs.setString('userData', userData);
    }
    try {
      await setUser(_token);
    } catch (error) {
      print(error.toString());
    }
    notifyListeners();
    _autoLogout();
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
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Phoenix.rebirth(context);
    notifyListeners();
  }

  ///Nullify the user automatically and reset the timer to log him out.
  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  ///A method that fetches for most recent playlists and set them in the most recent.
  ///It takes a [String] token for verification.
  Future<void> fetchFollowedArtists(String token) async {
    UserAPI userApi = UserAPI(baseUrl: baseUrl);
    try {
      final extractedList =
          await userApi.fetchFollowedArtistsApi(token);

      final List<Artist> loadedArtists = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedArtists.add(Artist.fromJson(extractedList[i]));
      }
      followedArtists = loadedArtists;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///Sends a http request to upgrade a user to premium.
  ///Confirmation code must be provided.
  ///An object from the API provider [UserAPI] to send requests is created.
  Future<void> upgradePremium(String confirmationCode) async {
    UserAPI userAPI = UserAPI(baseUrl: baseUrl);
    try {
      final responseData =
          await userAPI.upgradePremium(confirmationCode, token);
      if (responseData == true) {
        setPremium('premium');
        return;
      }
    } catch (error) {
      //print(error.toString());
      throw error;
    }
  }

  ///Sends a http request to send an email with a confirmation code to be a premium user.
  ///An object from the API provider [UserAPI] to send requests is created.
  Future<void> askForPremium() async {
    UserAPI userAPI = UserAPI(baseUrl: baseUrl);
    try {
      await userAPI.askForPremium(_token);
    } catch (error) {
      //print(error.toString());
      throw error;
    }
  }

  ///Sends a http request to follow a user given an id.
  ///Id must be provided.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> follow(String id) async {
    UserAPI userAPI = UserAPI(baseUrl: baseUrl);
    try {
      bool succeeded = await userAPI.followArtist(token, id);
      if (!succeeded) {
        throw HttpException('Couldn\,t follow this user');
      } else {
        followSuccessful = true;
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  ///Token must be provided for authentication.
  ///New password and Old password must be provided.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> changePassword(
      String token, String newpassword, String oldPassword) async {
    UserAPI userApi = UserAPI(baseUrl: baseUrl);
    try {
      bool success =
          await userApi.changePasswordApi(token, newpassword, oldPassword);
      if (success) {
        _user.password = newpassword;
        throw HttpException('Your password is changed successfully!!');
      } else {
        throw HttpException('Something went wrong please try again later!!');
      }
    } catch (error) {
      throw error;
    }
  }

  ///Token must be provided for authentication.
  ///New password and Old password must be provided.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> changeUserName(String token, String email, String userName,
      String gender, String dateOfBirth) async {
    UserAPI userApi = UserAPI(baseUrl: baseUrl);
    try {
      bool success = await userApi.changeUserNameApi(
          token, email, userName, gender, dateOfBirth);
      if (success) {
        _user.name = userName;
        throw HttpException('Your Name is changed successfully!!');
      } else {
        throw HttpException('Something went wrong please try again later!!');
      }
    } catch (error) {
      throw error;
    }
  }

  ///Token must be provided for authentication.
  ///New password and Old password must be provided.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> changeUserImage(String token, File imagePath) async {
    UserAPI userApi = UserAPI(baseUrl: baseUrl);
    try {
      bool success = await userApi.changeUserImageApi(token, imagePath);
      if (success) {
        throw HttpException('Your Image is changed successfully!!');
      } else {
        throw HttpException('Something went wrong please try again later!!');
      }
    } catch (error) {
      throw error;
    }
  }

  ///Token must be provided for authentication.
  ///Firebase token must be provided for update.
  ///An object from the API provider [UserAPI] to send requests is created.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> updateFirebaseToken(
      String userToken, String firebaseToken) async {
    UserAPI userApi = UserAPI(baseUrl: baseUrl);
    try {
      bool success =
          await userApi.updateFirebaseToken(userToken, firebaseToken);
      if (success) {
        return true;
      } else {
        throw HttpException('Something went wrong please try again later!!');
      }
    } catch (error) {
      throw error;
    }
  }

  ///A method that fetches for following users and set them in the following list.
  ///It takes a [String] token for verificationand id for this category.
  Future<void> fetchFollowing(String token) async {
    UserAPI userApi = UserAPI(baseUrl: baseUrl);
    try {
      final extractedList = await userApi.fetchFollowingApi(token);

      final List<User> following = [];
      for (int i = 0; i < extractedList.length; i++) {
        following.add(User.fromJson2(extractedList[i]));
      }
      followingUsers = following;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches for following users and set them in the following list.
  ///It takes a [String] token for verificationand id for this category.
  Future<void> fetchFollowers(String token) async {
    UserAPI userApi = UserAPI(baseUrl: baseUrl);
    try {
      final extractedList = await userApi.fetchFollowersApi(token);

      final List<User> following = [];
      for (int i = 0; i < extractedList.length; i++) {
        following.add(User.fromJson2(extractedList[i]));
      }
      followersUsers = following;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
