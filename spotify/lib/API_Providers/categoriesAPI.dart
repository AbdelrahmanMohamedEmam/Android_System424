import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:spotify/Models/http_exception.dart';

class CategoriesEndPoints {
  static const browse = '/browse';
  static const categories = '/categories';
}

class CategoriesAPI {
  final String baseUrl;
  CategoriesAPI({
    this.baseUrl,
  });

  ///A method that fetches categories.
  ///It takes a [token] of type [String].
  ///It return [List] of [Map<String,dynamic>].
  Future<List> fetchCategories(String token) async {
    final url =
        baseUrl + CategoriesEndPoints.browse + CategoriesEndPoints.categories;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> temp2 = temp['data'];
        final extractedList = temp2['categories'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
