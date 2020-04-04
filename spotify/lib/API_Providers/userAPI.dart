import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import '../Models/http_exception.dart';
import '../Models/user.dart';
import 'dart:convert';
class UserAPI{
  final String baseUrl;
  UserAPI({this.baseUrl});


  ///Facebook Login Attributes.
  ///An object of facebook plugin.
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
     if(response.statusCode==204) {
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




  Future<Map<String, dynamic>> signIn(String email, String password) async{
    final url = baseUrl+'/signIn';

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



  Future<User> setUser(String token) async {
    try {
      final response = await http.get(
        baseUrl+'/me',
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
            "facebook id": facebookId,
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

}