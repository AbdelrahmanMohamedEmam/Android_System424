import 'package:spotify/API_Providers/albumAPI.dart' as album;
import 'package:spotify/Models/album.dart';
import '../lib/API_Providers/albumAPI.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import '../lib/Models/artist.dart';
import 'dart:io' ;
class MockClient extends Mock implements album.AlbumAPI {}

main() {
  AlbumAPI album =  AlbumAPI(baseUrl : 'http://spotify.mocklab.io');
  File file;
  group('upload album', () {
    test('returns a Post if the http call completes successfully', () async {
      //final artist = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      //when(client.fetchChosenApi('', ''))
      //.thenReturn();

      final item = await album.uploadAlbumApi(file, '_', 'sahran', 'rock', '10-4-2020', 'house');
      //print();
      expect(item, true);
      //verify(artist.fetchChosenApi('_', '5abSRg0xN1NV3gLbuvX24M')).called(1);
      //expect(await client.fetchChosenApi('' ,''), const TypeMatcher<Artist>());
    });

    //test('throws an exception if the http call completes with an error', () {
    //final client = MockClient();

    // Use Mockito to return an unsuccessful response when it calls the
    // provided http.Client.
    //when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
    //  .thenAnswer((_) async => http.Response('Not Found', 404));

    // expect(fetchPost(client), throwsException);
    //});
  });
}