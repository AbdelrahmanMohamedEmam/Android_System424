import 'package:flutter/material.dart';
import 'package:spotify/Models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesProvider with ChangeNotifier {
  List<Category> _homeCategories = [];
  Future<void> fetchHomeScreenCategories() async {
    const url = '';
    final response = await http.get(url);
    final extractedList = json.decode(response.body) as List;
    final List<Category> loadedPlaylists = [];
    for (int i = 0; i < extractedList.length; i++) {
      loadedPlaylists.add(Category.fromJson(extractedList[i]));
    }
    _homeCategories = loadedPlaylists;
    notifyListeners();
  }
  // bool checkPopularAlbums(){
  //   return _homeCategories.
  // }
}
