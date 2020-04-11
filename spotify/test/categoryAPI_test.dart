import 'package:flutter_test/flutter_test.dart';
import 'package:spotify/API_Providers/categoriesAPI.dart';

void main() async {
  group('Category API Test', () {
    test('categories true', () async {
      final categoriesAPI =
          new CategoriesAPI(baseUrl: 'http://spotify.mocklab.io');
      final List<dynamic> item = await categoriesAPI.fetchCategories('token');
      expect(item[0]['_id'], '5e90e90751221e3224e30852');
      expect(item[1]['_id'], '5e90e90951221e3224e30853');
      expect(item[2]['_id'], '5e90e90951221e3224e30854');
      expect(item[3]['_id'], '5e90e90951221e3224e30855');
    });

    test('PlayHistory false', () async {
      final categoriesAPI =
          new CategoriesAPI(baseUrl: 'http://spotifybad.mocklab.io');
      expect(categoriesAPI.fetchCategories('token'),
          throwsA(isInstanceOf<Exception>()));
    });
  });
}
