import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

///Indicator to which [BottomNavigationBarItem] being pressed.
enum TabItem {
  ///The [HomeScreen] tab indicator.
  home,

  ///The [SearchScreen] tab indicator.
  search,

  ///The [LibraryScreen] tab indicator.
  library,

  ///The [PremiumScreen] tab indicator.
  premium,

  ///The [ArtistsScreen] tab indicator.
  artist,
}

class BottomNavigation extends StatelessWidget {
  ///Creates a [BottomNavigationBar] which is used as the.
  ///navigation bar through the 5 Tabs [HomeScreen],[SearchScreen],[LibraryScreen],[PremiumScreen],[ArtistScreen].
  BottomNavigation({
    this.currentTab,
    this.onSelectTab,
  });

  ///Indicator to the current chosen tab.
  final TabItem currentTab;

  ///`setState` to rebuild the bottom navigation bar with the new [currentIndex].
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    ///The device size provided by the [MediaQuery].
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white24,
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(48, 44, 44, 1),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: currentTab.index,
        iconSize: deviceSize.width * 0.06,
        elevation: 0,
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
            icon: Icon(FontAwesomeIcons.spotify),
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
      ),
    );
  }
}
