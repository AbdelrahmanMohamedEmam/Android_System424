import 'package:flutter/material.dart';
import 'package:spotify/API_Providers/categoriesAPI.dart';
import 'package:spotify/Models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesProvider with ChangeNotifier {
  final String baseUrl;
  CategoriesProvider({this.baseUrl});
  List<Category> _homeCategories = [];
  bool _pop = false;
  bool _happy = false;
  bool _arabic = false;
  bool _jazz = false;

  bool get isPop {
    return _pop;
  }

  bool get isHappy {
    return _happy;
  }

  bool get isArabic {
    return _arabic;
  }

  bool get isJazz {
    return _jazz;
  }

  String get getJazzCategoryId {
    final index =
        _homeCategories.indexWhere((category) => category.name == 'Jazz');
    return _homeCategories[index].id;
  }

  String get getHappyCategoryId {
    final index =
        _homeCategories.indexWhere((category) => category.name == 'Happy');
    return _homeCategories[index].id;
  }

  String get getArabicCategoryId {
    final index =
        _homeCategories.indexWhere((category) => category.name == 'Arabic');
    return _homeCategories[index].id;
  }

  String get getPopCategoryId {
    final index =
        _homeCategories.indexWhere((category) => category.name == 'Pop');
    return _homeCategories[index].id;
  }

  Future<void> fetchHomeScreenCategories(String token) async {
    CategoriesAPI categoriesAPI = CategoriesAPI(baseUrl: baseUrl);
    try {
      final extractedList = await categoriesAPI.fetchCategories(token);
      final List<Category> loadedPlaylists = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedPlaylists.add(Category.fromJson(extractedList[i]));
      }
      _homeCategories = loadedPlaylists;
      setCategories();
      notifyListeners();
    } catch (error) {}
  }

  void setCategories() {
    for (int i = 0; i < _homeCategories.length; i++) {
      if (_homeCategories[i].name == 'Jazz') {
        _jazz = true;
      } else if (_homeCategories[i].name == 'Pop') {
        _pop = true;
      } else if (_homeCategories[i].name == 'Arabic') {
        _arabic = true;
      } else if (_homeCategories[i].name == 'Happy') {
        _happy = true;
      }
    }
  }
}
