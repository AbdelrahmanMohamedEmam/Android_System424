import 'package:flutter_test/flutter_test.dart';
import 'package:spotify/API_Providers/albumAPI.dart';

void main() async {
  group('Album API Test', () {
    test('Popular Albums true', () async {
      final albumsAPI = new AlbumAPI(baseUrl: 'http://spotify.mocklab.io');
      final List<dynamic> item = await albumsAPI.fetchPopularAlbumsApi('token');
      expect(item[0]['_id'], '5e90e8fbe1451e424477b132');
      expect(item[1]['_id'], '5e90e8fbe1451e424477b133');
      expect(item[2]['_id'], '5e90e8fbe1451e424477b131');
      expect(item[3]['_id'], '5e90e8fbe1451e424477b134');
    });

    test('Popular Albums false', () async {
      final albumsAPI = new AlbumAPI(baseUrl: 'http://spotifybad.mocklab.io');
      expect(albumsAPI.fetchPopularAlbumsApi('token'),
          throwsA(isInstanceOf<Exception>()));
    });

    test('Most Recent Albums true', () async {
      final albumsAPI = new AlbumAPI(baseUrl: 'http://spotify.mocklab.io');
      final List<dynamic> item =
          await albumsAPI.fetchMostRecentAlbumsApi('token');
      expect(item[0]['_id'], '5e90e8fbe1451e424477b133');
      expect(item[1]['_id'], '5e90e8fbe1451e424477b131');
      expect(item[2]['_id'], '5e90e8fbe1451e424477b132');
      expect(item[3]['_id'], '5e90e8fbe1451e424477b134');
    });

    test('Most Recent Albums false', () async {
      final albumsAPI = new AlbumAPI(baseUrl: 'http://spotifybad.mocklab.io');
      expect(albumsAPI.fetchMostRecentAlbumsApi('token'),
          throwsA(isInstanceOf<Exception>()));
    });

    test('Album tracks true', () async {
      final albumsAPI = new AlbumAPI(baseUrl: 'http://spotify.mocklab.io');
      final List<dynamic> item =
          await albumsAPI.fetchAlbumsTracksApi('token', '1234');
      expect(item[0]['_id'], '5e90e902dbaa5b45a48541f3');
    });

    test('Album tracks false', () async {
      final albumsAPI = new AlbumAPI(baseUrl: 'http://spotifybad.mocklab.io');
      expect(albumsAPI.fetchAlbumsTracksApi('token', '1234'),
          throwsA(isInstanceOf<Exception>()));
    });

    test('My albums true', () async {
      final albumsAPI = new AlbumAPI(baseUrl: 'http://spotify.mocklab.io');
      final List<dynamic> item = await albumsAPI.fetchMyAlbumsApi('token');
      expect(item[0]['_id'], '5e90e8fbe1451e424477b131');
    });

    test('My albums false', () async {
      final albumsAPI = new AlbumAPI(baseUrl: 'http://spotifybad.mocklab.io');
      expect(albumsAPI.fetchMyAlbumsApi('token'),
          throwsA(isInstanceOf<Exception>()));
    });
  });
}
