///Importing dart libraries to use it.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify/Models/http_exception.dart';
import '../Models/artist.dart';

///Creates a [ArtistEndPoints] which is used as the.
///end points used for artist profile http requests.
class ArtistEndPoints {
  ///Indicator to the albums endpoint.
  static const String albums = '/albums';

  ///Indicator to the artists endpoint.
  static const String artists = '/artists';

  ///Indicator to the related artists endpoint.
  static const String relatedArtists = '/related-artists';

  ///Indicator to the top tracks endpoint.
  static const String topTracks = '/top-tracks';
}

///Creates a [ArtistAPI] which is used as the.
class ArtistAPI {
  /// Indicator tom set the [baseUrl] to know which source will data be loaded from.
  /// mock source or the original database [required] parameter.
  final String baseUrl;

  ///Constructor to set then baseUrl
  ArtistAPI({this.baseUrl});

  ///A method that fetches Artist information by ID.
  Future<Artist> fetchChosenApi(String token, String id) async {
    print('mahmoud');
    final url = baseUrl + ArtistEndPoints.artists + '/' + id;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 211) {
        Map<String, dynamic> temp = json.decode(response.body);
        Map<String, dynamic> extractedList = temp['data'];
        print(response.body);
        //Map<String, dynamic> extractedList = json.decode(response.body);
        Artist chosenArtist = Artist.fromJson(extractedList);
        return chosenArtist;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches Multiple artists which are related to the chosen artist by its ID.
  Future<List> fetchMultiApi(
    String token,
    String id,
  ) async {
    final url = baseUrl +
        ArtistEndPoints.artists +
        '/' +
        id +
        ArtistEndPoints.relatedArtists;
    try {
      final response = await http.get(
        url,
        headers: {'authorization': "Bearer " + token},
      );
      if (response.statusCode == 200 || response.statusCode == 211) {
        Map<String, dynamic> temp = json.decode(response.body);
        final extractedList = temp['data'] as List;
        return extractedList;
      } else {
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  ///A method that fetches all artists in the database to choose 3 of them to follow while signing-up.
  Future<List> fetchAllApi(String token) async {
    final url = baseUrl + ArtistEndPoints.artists;
    try {
      final response = await http.get(
        url,
        headers: {'authorization': token},
      );
      if (response.statusCode == 200 || response.statusCode == 211) {
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

