///Importing dart libraries to use it.
import 'dart:convert';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;


///Importing models.
import '../Models/http_exception.dart';
import '../Models/user.dart';


///This class provides functions to send all the requests required from [UserProvider].
///It provides authentication requests, such as sign up, sign in requests.
///It provides user related requests, such as upgrade user to premium.
class UserAPI{

  final String baseUrl;
  UserAPI({this.baseUrl});


  ///Facebook Login Attributes.
  ///An object of facebook plugin.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  var facebookLogin = FacebookLogin();

  Future<Map<String, dynamic>> signUp(String email, String password, String gender,
      String username, String dateOfBirth) async {
    try {
      final response = await http.post(
        baseUrl+'/signUp',
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "gender": gender,
            "dateOfBirth": dateOfBirth,
            "username": username,
          },
        ),
      );
      final responseData = jsonDecode(response.body);
      return responseData;
    } catch (error) {
      throw HttpException(error.toString());
    }
  }



  ///Sends a request to send an email to create a new password.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<bool> forgetPassword(String email) async {
  final url= baseUrl+'/resetPassword';

    try {
      final response = await http.post(
       url,
        body: jsonEncode(
          {
            "email": email,
          },
        ),
      );
     if(response.statusCode==204 || response.statusCode==200) {
       return true;
     }
     else {
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
  Future<Map<String, dynamic>> signIn(String email, String password) async{
    final url = 'http://www.mocky.io/v2/5e8a7b0a2d00006e1a1a4663';

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
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
      throw error;
    }

  }



  ///Sends a request to get the data of the user.
  ///Throws an error if request failed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<User> setUser(String token) async {
    try {
      final response = await http.get(
        'http://www.mocky.io/v2/5e8a7c262d00003c1a1a466b',
        headers: {'authorization': token},
      );

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
  Future<Map<String,dynamic>> signInWithFB() async {
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
          final response = await http
              .post(baseUrl+'/loginWithFacebook', body: {
            "access token": token,
            //"facebook id": facebookId,
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
      final response = await http.post(baseUrl+'/me/upgrade/'+confirmationCode,
        //body: {},
        //+confirmationCode,
        headers: {'authorization': token},
      );

      final responseData = jsonDecode(response.body);
      print(response.statusCode);

      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      } else if (response.statusCode==204 || response.statusCode==200) {
        return true;
      }
      else{
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
      final response = await http.post(baseUrl+'/me/premium',
        headers: {'authorization': token},
      );

      final responseData = jsonDecode(response.body);
      print(response.statusCode);

      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      } else if (response.statusCode==204 || response.statusCode==200) {
        print('asked for premium successfully');
        return;
      }
      else{
        throw HttpException('Couldn\'t send a request to send an email');
      }
    } catch (error) {
      print(error.toString());
      throw HttpException(error.toString());
    }
  }



}