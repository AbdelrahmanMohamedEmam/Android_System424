import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../Models/http_exception.dart';
import '../Models/user.dart';
import 'dart:convert';
class UserAPI{
  String baseUrl;
  UserAPI({this.baseUrl});


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


}