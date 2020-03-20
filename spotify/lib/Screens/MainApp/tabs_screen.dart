import 'package:flutter/material.dart';

import './home_screen.dart';
import './search_screen.dart';
import './library_screen.dart';
import './premium_screen.dart';
import './artist_screen.dart';
import 'home_screen.dart';
import 'search_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs_screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> pages = [
    HomeScreen(
      key: PageStorageKey('HomeScreen'),
    ),
    SearchScreen(
      key: PageStorageKey('SearchScreen'),
    ),
    LibraryScreen(
      key: PageStorageKey('LibraryScreen'),
    ),
    PremiumScreen(
      key: PageStorageKey('PremiumScreen'),
    ),
    ArtistScreen(
      key: PageStorageKey('ArtistScreen'),
    ),
  ];

  // index for the selected page
  int _selectedPageIndex = 0;

  // A function to change the seleted page index
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageStorage(
        child: pages[_selectedPageIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            title: Text('Library'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('Premium'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            title: Text('Artist'),
          ),
        ],
      ),
    );
  }
}
