import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AuthorizationProvider with ChangeNotifier{
  String _token;
  bool _status;

  bool get isAuth{
    return token !=null;
  }

  String get token{
    if (_token!=null){
      return _token;
    }
    return null;
  }


  Future<void> signUp(String email, String password,String gender,String username, String dateOfBirth)async {
    final url = '';


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


      if (responseData['error'] != null) {

        //Handle Error

      }
      else{
        _token = responseData['token'];
        _status= responseData['success'];
      }
      notifyListeners();
    } catch (error) {
      //throw error;
    }
  }



  Future<void> signIn(String email, String password)async {
    final url = '';


    try {
      final response = await http.post(url, body: jsonEncode({
        "email": email,
        "password": password,
         },
        ),
      );

      final responseData = jsonDecode(response.body);


      if (responseData['error'] != null) {

        //Handle Error

      }
      else{
        _token = responseData['token'];
        _status= responseData['success'];
      }
      notifyListeners();
    } catch (error) {
      //throw error;
    }
  }
}



