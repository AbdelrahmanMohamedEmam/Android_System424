import 'package:flutter_test/flutter_test.dart';
import 'package:spotify/API_Providers/playlistAPI.dart';

void main() async {
  group('Playlist API Test', () {
    test('Most recent Playlists true', () async {
      final playlistAPI = new PlaylistAPI(baseUrl: 'http://spotifybad.mocklab.io');
      final List<dynamic> item =
          await playlistAPI.fetchMostRecentPlaylistsApi('token');
      expect(item[0]['_id'], '5ee0be178f5f8395b97ba5f2');
      expect(item[1]['_id'], '5ee0acc0ec5a0890fe9ba7dc');
      expect(item[2]['_id'], '5ee017626ce952c5c02ec082');
      expect(item[3]['_id'], '5ee05fab6ce952c5c02ec226');
      expect(item[4]['_id'], '5ee0836d6ce952c5c02ec742');
    });


    test('popular Playlists true', () async {
      final playlistAPI = new PlaylistAPI(baseUrl: 'http://spotifybad.mocklab.io');
      final List<dynamic> item =
          await playlistAPI.fetchPopularPlaylistsApi('token');
      expect(item[0]['_id'], '5ec8443104c74ae8b5687105');
      expect(item[1]['_id'], '5ec8443104c74ae8b5687108');
      expect(item[2]['_id'], '5ec8443104c74ae8b5687102');
      expect(item[3]['_id'], '5ec8443104c74ae8b5687106');
      expect(item[4]['_id'], '5ec8443104c74ae8b5687107');
    });

    test('Playlist tracks true', () async {
      final playlistAPI = new PlaylistAPI(baseUrl: 'http://spotifybad.mocklab.io');
      final List<dynamic> item =
          await playlistAPI.fetchPlaylistsTracksApi('token', '5ec8443104c74ae8b5687105');
      expect(item[0]['_id'], '5ec844300d5a54e890e655ce');
    });

    test('Artists playlists true', () async {
      final playlistAPI = new PlaylistAPI(baseUrl: 'http://spotifybad.mocklab.io');
      final List<dynamic> item =
          await playlistAPI.fetchArtistPlaylistsApi('token', '5ec8442cee0c17e8674c3b10');
      expect(item[0]['_id'], '5ec8443104c74ae8b5687102');
      //expect(item[1]['_id'], '5e90e910c19b3c4e3c1ce094');
    });

   
  });
}
