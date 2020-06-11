import 'package:flutter_test/flutter_test.dart';
import '../lib/API_Providers/trackAPI.dart';

void main() async {
  group('Track API Test', () {
 

    test('Recently played', () async {
      final trackAPI = new TrackAPI(baseUrl: 'http://spotify.mocklab.io');
      final item = await trackAPI.addToRecentlyPlayed(
          'contextUri', 'trackUri', 'album', 'token');
      expect(item, true);
    });
  });
}
