///Importing dart libraries to use it.
import 'dart:convert';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:spotify/API_Providers/albumAPI.dart';

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
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  var facebookLogin = FacebookLogin();

  Future<Map<String, dynamic>> signUp(String email, String password,
      String gender, String username, String dateOfBirth) async {
    try {
      final response = await http.post(
        baseUrl + '/signUp',
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "gender": gender,
            "dateOfBirth": dateOfBirth,
            "name": username,
          },
        ),
      );
      final responseData = jsonDecode(response.body);
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      } else {
        return responseData;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///Sends a request to send an email to create a new password.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> forgetPassword(String email) async {
    final url = baseUrl + '/resetPassword';

    try {
      final response = await Dio().post(
        url,
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
      print(error.toString());
      throw error;
    }
  }

  ///Sends a request to get the authentication token of the user to sign him in.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final url = baseUrl + '/signIn';

    try {
      print(email);
      print(password);
      final responseData = await Dio().post(
        url,
        data: json.encode(
          {"email": email, "password": password},
        ),
      );
      print(responseData.statusCode);
      print(responseData.data);

      if (responseData.data['message'] != null) {
        throw HttpException(responseData.data['message']);
      } else {
        return responseData.data;
      }
    } catch (error) {
      throw error;
    }
  }

  ///Sends a request to get the data of the user.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<User> setUser(String token) async {
    try {
      print("TOKEN" + token);

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
        print(_user.id.toString());
        print(_user.password.toString());
        print(_user.email.toString());
        print(_user.name.toString());
        print(_user.externalUrl.toString());
        print(_user.gender.toString());
        print(_user.dateOfBirth.toString());
        print(_user.product);
        return _user;
      }
    } catch (error) {
      print(error.toString());
      throw HttpException(error.toString());
    }
  }

  ///Sends a http request to signIn/signUp with facebook account.
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
        final profile = jsonDecode(graphResponse.body);
        print(profile.toString());
        print(token);

        String facebookId = profile['id'];

        try {
          final response =
              await http.post(baseUrl + '/loginWithFacebook', body: {
            "access token": token,
          });
          final responseData = jsonDecode(response.body);

          if (responseData['message'] != null) {
            throw HttpException(responseData['message']);
          } else {
            return responseData;
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
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> upgradePremium(String confirmationCode, String token) async {
    try {
      final response = await http.post(
        baseUrl + '/me/upgrade/' + confirmationCode,
        headers: {'authorization': token},
      );

      final responseData = jsonDecode(response.body);
      print(response.statusCode);

      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      } else if (response.statusCode == 204 || response.statusCode == 200) {
        return true;
      } else {
        throw HttpException('Request failed! Check again later.');
      }
    } catch (error) {
      print(error.toString());
      throw HttpException(error.toString());
    }
  }

  ///Sends a request to send an email with a confirmation code to be a premium user.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> askForPremium(String token) async {
    try {
      final response = await http.post(
        baseUrl + '/me/premium',
        headers: {'authorization': token},
      );

      final responseData = jsonDecode(response.body);
      print(response.statusCode);

      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      } else if (response.statusCode == 204 || response.statusCode == 200) {
        print('asked for premium successfully');
        return;
      } else {
        throw HttpException('Couldn\'t send a request to send an email');
      }
    } catch (error) {
      print(error.toString());
      throw HttpException(error.toString());
    }
  }

  ///Sends a request to follow an artist given the id.
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
      if (response.statusCode == 304 ||
          response.statusCode == 200 ||
          response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<bool> changePasswordApi(
      String token, String newPassword, String oldPassword) async {
    print(token);
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
    print(newPassword);
    print(oldPassword);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
