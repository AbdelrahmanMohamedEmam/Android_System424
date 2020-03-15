import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/playlist.dart';
class PlaylistProvider with ChangeNotifier{
List<Playlist> _playlists=[];


List<Playlist> get playlists{
  return [..._playlists];
}
Future<void> fetchPlaylists() async{
  const url='http://www.mocky.io/v2/5e6d571d2e00009d000eebb5';
    final response=await http.get(url);
    final extractedData=json.decode(response.body) as Map<String,dynamic>;
    final List<Playlist> loadedPlaylists =[];
    loadedPlaylists.add(Playlist.fromJson(extractedData));
}

}