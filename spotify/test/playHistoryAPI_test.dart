import 'package:flutter_test/flutter_test.dart';
import 'package:spotify/API_Providers/playHistoryAPI.dart';

void main() async {
  group('PlaylistHistory API Test', () {
    test('PlayHistory true', () async {
      final playHistoryAPI =
          new PlayHistoryAPI(baseUrl: 'http://spotify.mocklab.io');
      final List<dynamic> item =
          await playHistoryAPI.fetchRecentlyPlayedApi('token');
      expect(item[0]['track']['album'], '5e90e8fbe1451e424477b131');
    });
    // test('PlayHistory false', () async {
    //   final playHistoryAPI =
    //       new PlayHistoryAPI(baseUrl: 'http://spotifybad.mocklab.io');
    //   expect(playHistoryAPI.fetchRecentlyPlayedApi('token'),
    //       throwsA(isInstanceOf<Exception>()));
    // });
  });
}
