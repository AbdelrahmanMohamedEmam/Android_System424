import 'package:spotify/API_Providers/artistAPI.dart' as artist;
import 'package:spotify/Models/artist.dart';
import '../lib/API_Providers/artistAPI.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import '../lib/Models/artist.dart';


main() {
  ArtistAPI artist =  ArtistAPI(baseUrl : 'http://spotify.mocklab.io');
  group('ArtistInfo', () {
    test('returns a Post if the http call completes successfully', () async {
      //final artist = MockClient(baseUrl : 'http://spotify.mocklab.io');

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      //when(client.fetchChosenApi('', ''))
          //.thenReturn();
      final item = await artist.fetchChosenApi('_', '5abSRg0xN1NV3gLbuvX24M');
      print(item.name);
      expect(item.name, 'Amr Diab');
      //verifyNever(artist.fetchChosenApi('_', '5abSRg0xN1NV3gLbuvX24M')).called(1);
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