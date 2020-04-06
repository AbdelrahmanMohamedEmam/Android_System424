///Importing dart libraries to use it.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify/Models/http_exception.dart';

class AlbumEndPoints {
  static const String albums = '/albums';
  static const String popular = '/popular';
  static const String mostRecent = '/most-recent';
}

class AlbumAPI {
  final String baseUrl;
  AlbumAPI({this.baseUrl});

  Future<List> fetchPopularAlbumsApi(String token) async {
    final url = baseUrl +
        AlbumEndPoints.albums +
        AlbumEndPoints.popular; //base url to be added
    try {
      final response = await http.get(
        url,
        headers: {'authorization': token},
      );
      if (response.statusCode == 200) {
        final extractedList = json.decode(response.body) as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<List> fetchMostRecentAlbumsApi(String token) async {
    final url = baseUrl +
        AlbumEndPoints.albums +
        AlbumEndPoints.mostRecent; //base url to be added
    try {
      final response = await http.get(
        url,
        headers: {'authorization': token},
      );
      if (response.statusCode == 200) {
        final extractedList = json.decode(response.body) as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
