///Importing dart libraries to use it.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

///Importing models.
import '../Models/http_exception.dart';
import '../Models/user.dart';

///This class provides functions to send all the requests required from [UserProvider].
///It provides authentication requests, such as sign up, sign in requests.
///It provides user related requests, such as upgrade user to premium.
class UserAPI {
  final String baseUrl;
  UserAPI({this.baseUrl});

  ///Facebook Login Attributes.
  ///An object of facebook plugin.
  var facebookLogin = FacebookLogin();

  ///A request to signUp a new user.
  ///Email, password, gender, username and date of birth must be provided.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  ///In case of success the data is returned as a map of keys and dynamic objects.
  ///In case of failure an exception is thrown.
  Future<Map<String, dynamic>> signUp(String email, String password,
      String gender, String username, String dateOfBirth) async {
    try {
      final responseData = await Dio().post(
        baseUrl + '/signUp',
        options: Options(validateStatus: (_) {
          return true;
        }),
        data: jsonEncode(
          {
            "email": email,
            "password": password,
            "gender": gender,
            "dateOfBirth": dateOfBirth,
            "name": username,
          },
        ),
      );
      //final responseData = jsonDecode(response.body);
      print(responseData.data.toString());
      if (responseData.data['message'] != null) {
        //throw HttpException(responseData.data['message']);
      } else {
        print(responseData.data);
        return responseData.data;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///Sends a request to send an email to create a new password.
  ///Email must be provided.
  ///In case of success it will return true.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> forgetPassword(String email) async {
    final url = baseUrl + '/resetPassword';

    try {
      final response = await Dio().post(
        url,
        options: Options(validateStatus: (_) {
          return true;
        }),
        data: jsonEncode(
          {
            "email": email,
          },
        ),
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      //print(error.toString());
      throw error;
    }
  }

  ///Sends a request to get the authentication token of the user to sign him in.
  ///Email and password must be provided.
  ///In case of success a map of keys and dynamic values will be returned.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final url = baseUrl + '/signIn';

    try {
      final responseData = await Dio().post(
        url,
        options: Options(
          validateStatus: (_) {
            return true;
          },
          receiveDataWhenStatusError: true,
        ),
        data: json.encode(
          {"email": email, "password": password},
        ),
      );

      print(responseData.data);
      if (responseData.statusCode != 200) {
        print('errorrrr');
        throw HttpException(json.decode(responseData.data)['message'].toString());
      } else {
        print(responseData.data);
        return responseData.data;
      }
    } catch (error) {
      throw error;
    }
  }

  ///Sends a request to get the data of the user.
  ///Token must be provided for authentication.
  ///In case of inthe success an object from model [User] will be returned containing all the used info needed.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<User> setUser(String token) async {
    try {
      final response = await http.get(baseUrl + '/me', headers: {
        "authorization": "Bearer " + token,
      });

      final responseData = jsonDecode(response.body);
      print(responseData);

      User _user;
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      } else {
        _user = User.fromJson(responseData);
        return _user;
      }
    } catch (error) {
      //print(error.toString());
      throw HttpException(error.toString());
    }
  }

  ///Sends a http request to signIn/signUp with facebook account.
  ///In case of success a map of keys and dynamics is returned.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<Map<String, dynamic>> signInWithFB() async {
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=' +
                token);

        try {
          final responseData = await Dio().post(baseUrl + '/loginWithFacebook',
              options: Options(validateStatus: (_) {
            return true;
          }), data: {
            "access_token": token,
          });
          if (responseData.data['message'] != null) {
            throw HttpException(responseData.data['message']);
          } else {
            return responseData.data;
          }
        } catch (error) {
          throw HttpException(error.toString());
        }
        break;

      case FacebookLoginStatus.cancelledByUser:
        throw HttpException('Login With Facebook Cancelled');
        break;
      case FacebookLoginStatus.error:
        throw HttpException('Login With Facebook Failed');
        break;
    }
  }

  ///Sends a request to upgrade the user to be a premium user.
  ///Token must be provided for authentication.
  ///Confirmation code must be provided.
  ///In case of success true is returned.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> upgradePremium(String confirmationCode, String token) async {
    try {
      final response = await http.post(
        baseUrl + '/me/upgrade/' + confirmationCode,
        headers: {"authorization": "Bearer " + token},
      );

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw HttpException('Couldn\'t upgrade you, sorry for that.');
      } else if (response.statusCode == 204 || response.statusCode == 200) {
        return true;
      } else {
        throw HttpException('Request failed! Check again later.');
      }
    } catch (error) {
      //print(error.toString());
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchFollowedArtistsApi(String token) async {
    final url = baseUrl + '/me/likedArtists';
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['users'] as List;

        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///Sends a request to send an email with a confirmation code to be a premium user.
  ///Token must be provided for authentication.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> askForPremium(String token) async {
    try {
      final response = await http.post(
        baseUrl + '/me/premium',
        headers: {
          "authorization": "Bearer " + token,
        },
      );

      //final responseData = jsonDecode(response.body);
      //print(responseData);

      if (response.statusCode != 204) {
        throw HttpException('Couldn\'t send an email');
      } else if (response.statusCode == 204 || response.statusCode == 200) {
        return true;
      } else {
        //print(responseData);
        throw HttpException('Couldn\'t send a request to send an email');
      }
    } catch (error) {
      //print(error.toString());
      throw HttpException(error.toString());
    }
  }

  ///Sends a request to follow an artist given the id.
  ///Id must be provided.
  ///Token must be provided for authentication.
  ///In case of success true is returned.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> followArtist(String token, String id) async {
    try {
      final response = await http.put(baseUrl + '/me/following',
          body: jsonEncode(
            {
              "id": id,
            },
          ),
          headers: {"authorization": token});
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///Sends a request to follow a user given the id.
  ///Id must be provided.
  ///Token must be provided for authentication.
  ///In case of success true is returned.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> follow(String token, String id) async {
    try {
      final response = await Dio().put(
        baseUrl + '/me' + '/following',
        options: Options(
            headers: {"authorization": "Bearer " + token},
            validateStatus: (_) {
              return true;
            }),
        data: json.encode(
          {
            "id": id,
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///Sends a request to follow a user given the id.
  ///Id must be provided.
  ///Token must be provided for authentication.
  ///In case of success true is returned.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> unfollowFollowUser(String token, String id) async {
    try {
      final response = await Dio().delete(
        baseUrl + '/me' + '/following',
        options: Options(
            headers: {"authorization": "Bearer " + token},
            validateStatus: (_) {
              return true;
            }),
        data: json.encode(
          {
            "id": id,
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///Sends a request to change the password.
  ///Old password and new password must be provided.
  ///Token must be provided for authentication.
  ///In case of success true is returned.
  ///In case of failure false is returned.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> changePasswordApi(
      String token, String newPassword, String oldPassword) async {
    final response = await Dio().put(baseUrl + '/me' + '/changePassword',
        data: json.encode(
          {"newPassword": newPassword, "passwordConfirmation": oldPassword},
        ),
        options: Options(
          validateStatus: (_) {
            return true;
          },
          headers: {
            "authorization": "Bearer " + token,
          },
        ));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  ///Sends a request to change the userName.
  ///email and userName and gender and dateOfBirth must be provided.
  ///Token must be provided for authentication.
  ///In case of success true is returned.
  ///In case of failure false is returned.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> changeUserNameApi(String token, String email, String userName,
      String gender, String dateOfBirth) async {
    final response = await Dio().put(baseUrl + '/me',
        data: json.encode(
          {
            "email": email,
            "name": userName,
            "gender": gender,
            "dateOfBirth": dateOfBirth
          },
        ),
        options: Options(
          validateStatus: (_) {
            return true;
          },
          headers: {
            "authorization": "Bearer " + token,
          },
        ));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  ///Sends a request to update the firebase token in the database.
  ///Email and password must be provided.
  ///In case of success a status code of 204 is returned.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> updateFirebaseToken(
      String userToken, String firebaseToken) async {
    final url = baseUrl + '/me/notifications/token';

    try {
      final responseData = await Dio().put(
        url,
        options: Options(
          headers: {
            "authorization": "Bearer " + userToken,
          },
          validateStatus: (_) {
            return true;
          },
          receiveDataWhenStatusError: true,
        ),
        data: json.encode(
          {"type": 'android', "token": firebaseToken},
        ),
      );

      print('updateResponse: ' + responseData.statusCode.toString());
      if (responseData.statusCode != 204) {
        throw HttpException(json.decode(responseData.data)['message']);
      } else {
        print(responseData.data);
        return true;
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  ///Sends a request to change the userImage.
  ///formData containig the image must be provided.
  ///Token must be provided for authentication.
  ///In case of success true is returned.
  ///In case of failure false is returned.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> changeUserImageApi(String token, File image) async {
    FormData formData = new FormData.fromMap({
      "image": image,
    });
    final response = await Dio().put(baseUrl + '/me' + '/image',
        data: formData,
        options: Options(
          validateStatus: (_) {
            return true;
          },
          headers: {
            "authorization": "Bearer " + token,
          },
        ));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> fetchFollowingApi(String token) async {
    final url = baseUrl + '/me' + '/following';
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        final extractedList = temp['data']['users'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchFollowersApi(String token) async {
    final url = baseUrl + '/me' + '/followers';
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        final extractedList = temp['data']['users'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
