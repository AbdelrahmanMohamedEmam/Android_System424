import 'package:spotify/API_Providers/albumAPI.dart' as album;
import 'package:spotify/Models/album.dart';
import '../lib/API_Providers/albumAPI.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import '../lib/Models/artist.dart';
import 'dart:io' ;


main() {
  AlbumAPI album =  AlbumAPI(baseUrl : 'http://spotify.mocklab.io');
  group('upload album', ()
  {
    test(
        'album uploaded successfully', () async {
      final item = await album.uploadAlbumApi(
          'filePath', '_', 'sahran', 'rock', '10-4-2020', 'house');
      expect(item, true);
    });
    test(
        'track uploaded successfully', () async {
      final item = await album.uploadSongApi( '_', 'SongName', 'filePath', 'albumId');
      expect(item,false);
    });
  });
}