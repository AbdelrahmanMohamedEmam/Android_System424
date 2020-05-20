///Importing dart libraries to use it.
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:spotify/Models/http_exception.dart';
import 'package:spotify/Providers/playable_track.dart';
import 'package:http/http.dart' as http;

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


  ///A request to get tracks liked by a new user.
  ///Token and limit must be provided.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  ///In case of success the data is returned as a map of keys and dynamic objects.
  ///In case of failure an exception is thrown.
  Future<List<dynamic>> fetchUserLikedTracks(String token, int limit) async {
    try {
      final responseData = await http.get(
      baseUrl + '/me/likedTracks?limit+'+limit.toString(),
            headers: {"authorization": "Bearer " + token},

      );
      print(responseData.statusCode);
      print(responseData.body);
      if (responseData.statusCode!= 200) {
        throw HttpException(jsonDecode(responseData.body)['message']);
      } else {
        return jsonDecode(responseData.body)['data']['tracks'];
      }
    } catch (error) {
      print(error.toString());
      throw HttpException(error.toString());
    }
  }

  Future<bool> likeTrack(String token, String trackId) async{
    try{
      final responseData = await Dio().put(
        baseUrl + '/me/likeTrack',
        //'http://spotify.mocklab.io'+'/me/likeTrack',
        options: Options(
            headers: {"authorization": "Bearer " + token},
            validateStatus: (_) {
              return true;
            }),
        data: json.encode({
          "id": trackId,
        })
      );
      print(responseData.statusCode);
      if(responseData.statusCode==204)
        {
          return true;
        }
      else{
       return false;
      }
    }catch(error){
      print(error.toString());
      throw error;
    }
  }

  Future<bool> unlikeTrack(String token, String trackId) async{
    try{
      final responseData = await Dio().delete(
        baseUrl + '/me/unlikeTrack',
          options: Options(
              headers: {"authorization": "Bearer " + token},
              validateStatus: (_) {
                return true;
              }),
          data: json.encode({
            "id": trackId,
          })
      );
      print(responseData.statusCode);
      if(responseData.statusCode==204)
      {
        return true;
      }
      else{
        return false;
      }
    }catch(error){
      print(error.toString());
      throw error;
    }
  }


  Future<bool> nextTrack(String token) async{
    try{
      final responseData = await Dio().put(
          baseUrl + '/me/player/next',
          options: Options(
              headers: {"authorization": "Bearer " + token},
              validateStatus: (_) {
                return true;
              }),
      );
      print('Next Track code:' + responseData.statusCode.toString());
      if(responseData.statusCode==204)
      {
        return true;
      }
      else{
        return false;
      }
    }catch(error){
      print(error.toString());
      throw error;
    }
  }

  Future<bool> previousTrack(String token) async{
    try{
      final responseData = await Dio().put(
        baseUrl + '/me/player/previous',
        options: Options(
            headers: {"authorization": "Bearer " + token},
            validateStatus: (_) {
              return true;
            }),
      );
      print('Previous Track code:' + responseData.statusCode.toString());
      if(responseData.statusCode==204)
      {
        return true;
      }
      else{
        return false;
      }
    }catch(error){
      print(error.toString());
      throw error;
    }
  }

  Future<bool> finishedTrack(String token) async{
    try{
      final responseData = await Dio().put(
        baseUrl + '/me/player/finished',
        options: Options(
            headers: {"authorization": "Bearer " + token},
            validateStatus: (_) {
              return true;
            }),
      );
      print('Next Track code:' + responseData.statusCode.toString());
      if(responseData.statusCode==204)
      {
        return true;
      }
      else{
        return false;
      }
    }catch(error){
      print(error.toString());
      throw error;
    }
  }


}
