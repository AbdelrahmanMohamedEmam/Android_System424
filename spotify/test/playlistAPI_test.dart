import 'package:flutter_test/flutter_test.dart';
import 'package:spotify/API_Providers/playlistAPI.dart';

void main() async {
  group('Playlist API Test', () {
    test('Popular Playlists true', () async {
      final playlistAPI = new PlaylistAPI(baseUrl: 'http://spotify.mocklab.io');
      final List<dynamic> item =
          await playlistAPI.fetchMostRecentPlaylistsApi('token');
      expect(item[0]['_id'], '5e90e910c19b3c4e3c1ce098');
      expect(item[1]['_id'], '5e90e910c19b3c4e3c1ce097');
      expect(item[2]['_id'], '5e90e910c19b3c4e3c1ce096');
      expect(item[3]['_id'], '5e90e910c19b3c4e3c1ce095');
      expect(item[4]['_id'], '5e90e910c19b3c4e3c1ce094');
    });

    test('popular playlists false', () async {
      final playlistAPI =
          new PlaylistAPI(baseUrl: 'http://spotifybad.mocklab.io');
      expect(playlistAPI.fetchPopularPlaylistsApi('token'),
          throwsA(isInstanceOf<Exception>()));
    });

    test('Most Recent Playlists true', () async {
      final playlistAPI = new PlaylistAPI(baseUrl: 'http://spotify.mocklab.io');
      final List<dynamic> item =
          await playlistAPI.fetchPopularPlaylistsApi('token');
      expect(item[0]['_id'], '5e90e910c19b3c4e3c1ce095');
      expect(item[1]['_id'], '5e90e910c19b3c4e3c1ce098');
      expect(item[2]['_id'], '5e90e910c19b3c4e3c1ce092');
      expect(item[3]['_id'], '5e90e910c19b3c4e3c1ce096');
      expect(item[4]['_id'], '5e90e910c19b3c4e3c1ce097');
    });

    test('Most recent false', () async {
      final playlistAPI =
          new PlaylistAPI(baseUrl: 'http://spotifybad.mocklab.io');
      expect(playlistAPI.fetchMostRecentPlaylistsApi('token'),
          throwsA(isInstanceOf<Exception>()));
    });

    test('Playlist tracks true', () async {
      final playlistAPI = new PlaylistAPI(baseUrl: 'http://spotify.mocklab.io');
      final List<dynamic> item =
          await playlistAPI.fetchPlaylistsTracksApi('token', '1234');
      expect(item[0]['_id'], '5e90e902dbaa5b45a48541ef');
      expect(item[1]['_id'], '5e90e902dbaa5b45a48541f0');
    });

    /*test('Playlist tracks false', () async {
      final playlistAPI =
          new PlaylistAPI(baseUrl: 'http://spotifybad.mocklab.io');
      expect(playlistAPI.fetchPlaylistsTracksApi('token', '1234'),
          throwsA(isInstanceOf<Exception>()));
    });*/

    test('Artists playlists true', () async {
      final playlistAPI = new PlaylistAPI(baseUrl: 'http://spotify.mocklab.io');
      final List<dynamic> item =
          await playlistAPI.fetchArtistPlaylistsApi('token', '5e923dd09df6d9ca9f10a473');
      expect(item[0]['_id'], '5e90e910c19b3c4e3c1ce091');
      expect(item[1]['_id'], '5e90e910c19b3c4e3c1ce094');
    });

    // test('Artists playlists false', () async {
    //   final playlistAPI =
    //       new PlaylistAPI(baseUrl: 'http://spotifybad.mocklab.io');
    //   expect(playlistAPI.fetchArtistPlaylistsApi('token', '1234'),
    //       throwsA(isInstanceOf<Exception>()));
    // });
  });
}
