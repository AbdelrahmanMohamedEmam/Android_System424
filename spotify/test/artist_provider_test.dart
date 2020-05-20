import 'package:spotify/Models/artist.dart';
import '../lib/API_Providers/artistAPI.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import '../lib/Models/artist.dart';

main() {
  ArtistAPI artist = ArtistAPI(baseUrl: 'http://spotify.mocklab.io');
  group('ArtistInfo', () {
    test('artist info loaded successfully', () async {
      final item = await artist.fetchChosenApi('_', '5e923dd09df6d9ca9f10a473');
      expect(item.name, 'Amr Diab');
      expect(item.type, 'artist');
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

  group('related artists', () {
    test('artist info loaded successfully', () async {
      final item = await artist.fetchMultiApi('_', '5abSRg0xN1NV3gLbuvX24M');
      expect(item[0]['name'], 'Amr Diab');
      expect(item[0]['artistInfo']['biography'], 'hjdjkkd;cmx');
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
