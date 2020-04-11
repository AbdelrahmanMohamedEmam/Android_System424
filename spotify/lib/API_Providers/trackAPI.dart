///Importing dart libraries to use it.
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:spotify/Models/http_exception.dart';
import 'package:spotify/Providers/playable_track.dart';

///This class is used to make the requests using the REST APIs that are related to the track object providing [PlayableTrackProvider].
class TrackAPI {
  final String baseUrl;
  TrackAPI({this.baseUrl});

  ///A request to add a track to the recently played list.
  ///The track uri, its context uri and the context type(either album or artist) is provided to the function.
  ///The users token is provided to the function for authentication.
  ///The request will return true if song was added successfully.
  ///The request will throw an exception if the song couldn't be added.
  Future<bool> addToRecentlyPlayed(String contextUri, String trackUri,
      String contextType, String token) async {
    try {
      final response = await Dio().post(
        baseUrl + '/me/player/recentlyPlayed',
        options: Options(
            headers: {"authorization": "Bearer " + token},
            validateStatus: (_) {
              return true;
            }),
        data: json.encode({
          "contextUri": contextUri,
          "trackUri": trackUri,
          "contextType": contextType
        }),
      );

      if (response.statusCode != 204) {
        throw HttpException('Couldn\'t add song to recently played.');
      } else if (response.statusCode == 204 || response.statusCode == 200) {
        //print('SONG ADDED SUCCESSFULLY');
        return true;
      } else {
        throw HttpException('Request failed! Check again later.');
      }
    } catch (error) {
      //print(error.toString());
      throw HttpException(error.toString());
    }
  }
}
