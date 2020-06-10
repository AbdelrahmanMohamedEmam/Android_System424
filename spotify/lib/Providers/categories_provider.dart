import 'package:flutter/material.dart';
import 'package:spotify/API_Providers/categoriesAPI.dart';
import 'package:spotify/Models/category.dart';

///Class Categories Provider.
class CategoriesProvider with ChangeNotifier {
  ///The baseUrl.
  final String baseUrl;

  ///Constrcutor with named argument assignment.
  CategoriesProvider({this.baseUrl});

  ///List of categories at the home page ex:(jazz,pop,arabic).
  List<Category> _homeCategories = [];

  ///Indication to know if the pop catecory is available or not.
  bool _pop = false;

  ///Indication to know if the happy catecory is available or not.
  bool _happy = false;

  ///Indication to know if the arabic catecory is available or not.
  bool _arabic = false;

  ///Indication to know if the jazz catecory is available or not.
  bool _jazz = false;

  ///A method getter to show if the pop category is available or not.
  bool get isPop {
    return _pop;
  }

  ///A method getter to show if the happy category is available or not.
  bool get isHappy {
    return _happy;
  }

  ///A method getter to show if the arabic category is available or not.
  bool get isArabic {
    return _arabic;
  }

  ///A method getter to show if the jazz category is available or not.
  bool get isJazz {
    return _jazz;
  }

  

  ///A method getter to get the jazz category's ID.
  String get getJazzCategoryId {
    final index =
        _homeCategories.indexWhere((category) => category.name == 'Jazz');
    return _homeCategories[index].id;
  }

  ///A method getter to get the hapoy category's ID.
  String get getHappyCategoryId {
    final index =
        _homeCategories.indexWhere((category) => category.name == 'Happy');
    return _homeCategories[index].id;
  }

  ///A method getter to get the hapoy category's ID.
  String get getMadeForYouCategoryId {
    final index =
        _homeCategories.indexWhere((category) => category.name == 'MadeForYou');
    return _homeCategories[index].id;
  }

  ///A method getter to get the arabic category's ID.
  String get getArabicCategoryId {
    final index =
        _homeCategories.indexWhere((category) => category.name == 'Arabic');
    return _homeCategories[index].id;
  }

  ///A method getter to get the pop category's ID.
  String get getPopCategoryId {
    final index =
        _homeCategories.indexWhere((category) => category.name == 'Pop');
    return _homeCategories[index].id;
  }

  ///A method that fetches the categories and set them in the homecategories List.
  ///It takes a [String] tpken for verification.
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

  ///A method to set the bool flags for each category if available.
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
