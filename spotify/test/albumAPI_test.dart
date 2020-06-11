import 'package:flutter_test/flutter_test.dart';
import 'package:spotify/API_Providers/albumAPI.dart';

void main() async {
  group('Album API Test', () {
    test('Popular Albums true', () async {
      final albumsAPI = new AlbumAPI(baseUrl: 'http://spotifybad.mocklab.io');
      final List<dynamic> item = await albumsAPI.fetchPopularAlbumsApi('token');
      expect(item[0]['_id'], '5ec84430fcf468e8807fb646');
      expect(item[1]['_id'], '5ec844341caeb6e8ebcca3a7');
      expect(item[2]['_id'], '5ec84430fcf468e8807fb647');
      expect(item[3]['_id'], '5ec844341caeb6e8ebcca3a8');
    });

    test('Most Recent Albums true', () async {
      final albumsAPI = new AlbumAPI(baseUrl: 'http://spotifybad.mocklab.io');
      final List<dynamic> item =
          await albumsAPI.fetchMostRecentAlbumsApi('token');
      expect(item[0]['_id'], '5ec84430fcf468e8807fb645');
      expect(item[1]['_id'], '5ec84430fcf468e8807fb646');
      expect(item[2]['_id'], '5ec84430fcf468e8807fb647');
      expect(item[3]['_id'], '5ec84430fcf468e8807fb648');
    });
      test('Album tracks true', () async {
      final albumsAPI = new AlbumAPI(baseUrl: 'http://spotifybad.mocklab.io');
      final List<dynamic> item =
          await albumsAPI.fetchAlbumsTracksApi('token', '5ec84430fcf468e8807fb647');
      expect(item[0]['_id'], '5ec844300d5a54e890e655d4');
    });

    test('My albums true', () async {
      final albumsAPI = new AlbumAPI(baseUrl: 'http://spotifybad.mocklab.io');
      final List<dynamic> item = await albumsAPI.fetchMyAlbumsApi('token');
      expect(item[0]['_id'], '5edffc0a535b988615daba1e');
    });

  });
}
