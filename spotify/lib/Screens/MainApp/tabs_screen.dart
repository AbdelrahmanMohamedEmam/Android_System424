/*import 'package:flutter/material.dart';

import './bottom_navigation_bar.dart';
import './tab_navigator.dart';
import '../../Widgets/trackPlayer.dart';

class TabNavigatorRoutes {
  static const String home = '/';
  static const String search = '/';
  static const String library = '/';
  static const String artist = '/';
  static const String premium = '/';
  static const String settings = '//settings';
  static const String premium2 = '//premium';
}

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs_screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  static TabItem _currentTab = TabItem.home;

  static Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.library: GlobalKey<NavigatorState>(),
    TabItem.premium: GlobalKey<NavigatorState>(),
    TabItem.artist: GlobalKey<NavigatorState>(),
  };

  final List<Widget> pages = [
    TabNavigator(
        route: TabNavigatorRoutes.search,
        navigatorKey: _navigatorKeys[TabItem.home],
        tabItem: TabItem.home,
      ),
    
    TabNavigator(
      route: TabNavigatorRoutes.search,
      navigatorKey: _navigatorKeys[TabItem.search],
      tabItem: TabItem.search,
    ),
    TabNavigator(
      route: TabNavigatorRoutes.library,
      navigatorKey: _navigatorKeys[TabItem.library],
      tabItem: TabItem.library,
    ),
    TabNavigator(
      route: TabNavigatorRoutes.premium,
      navigatorKey: _navigatorKeys[TabItem.premium],
      tabItem: TabItem.premium,
    ),
    TabNavigator(
      route: TabNavigatorRoutes.artist,
      navigatorKey: _navigatorKeys[TabItem.artist],
      tabItem: TabItem.artist,
    ),
  ];
  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.home) {
            // select 'main' tab
            _selectTab(TabItem.home);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: TrackPlayer(body:pages[_currentTab.index]),
        // body: IndexedStack(
        //   index: _currentTab.index,
        //   children: <Widget>[
        //     _buildOffstageNavigator(TabItem.home),
        //     _buildOffstageNavigator(TabItem.search),
        //     _buildOffstageNavigator(TabItem.library),
        //     _buildOffstageNavigator(TabItem.premium),
        //     _buildOffstageNavigator(TabItem.artist),
        //   ],
        // ),
        bottomNavigationBar:  BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  // Widget _buildOffstageNavigator(TabItem tabItem) {
  //   return TabNavigator(
  //     route: TabNavigatorRoutes.home,
  //     navigatorKey: _navigatorKeys[tabItem],
  //     tabItem: tabItem,
  //   );
  // }
}
*/