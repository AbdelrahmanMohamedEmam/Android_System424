import 'package:flutter/material.dart';

enum TabItem {
  home,
  search,
  library,
  premium,
  artist,
}
Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.search: 'Search',
  TabItem.library: 'Library',
  TabItem.premium: 'Premium',
  TabItem.artist: 'Artist',
};

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(48, 44, 44, 1),
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.white,
      currentIndex: currentTab.index,
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
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }
}
