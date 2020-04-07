///Importing dart libraries to use it.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:spotify/Models/http_exception.dart';
import '../Models/artist.dart';


class TrackAPI {
  final String baseUrl;
  TrackAPI({this.baseUrl});


  Future<bool> addToRecentlyPlayed(String contextUri,String trackUri, String contextType, String token) async {

    print (contextUri);
    print (contextType);
    print(trackUri);
    print(token);
    try {
      final response = await Dio().post(baseUrl+'/me/player/recentlyPlayed',
        options: Options(headers: {"authorization": "Bearer "+token},
        validateStatus: (_){return true;}),
        data: json.encode(
            {
              "contextUri": contextUri,
              "trackUri": trackUri,
              "contextType": contextType
            }
        ),
      );

      print(response.statusCode);
      print(response);
      if (response.statusCode != 204) {
        throw HttpException('Couldn\'t add song to recently played.');
      } else if (response.statusCode==204 || response.statusCode==200) {
        print('SONG ADDED SUCCESSFULLY');
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



}
