import 'package:flutter/material.dart';
import 'package:spotify/Screens/MainApp/artist_screen.dart';
import 'package:spotify/Screens/MainApp/library_screen.dart';
import 'package:spotify/Screens/MainApp/premium_screen.dart';
import '../../widgets/bottom_navigation_bar.dart';
import './home_screen.dart';
import './setting_screen.dart';
import './search_screen.dart';
import '../ArtistProfile/see_discography_screen.dart';
import '../Playlists/playlists_list_screen.dart';

Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
  TabItem.home: GlobalKey<NavigatorState>(),
  TabItem.search: GlobalKey<NavigatorState>(),
  TabItem.library: GlobalKey<NavigatorState>(),
  TabItem.premium: GlobalKey<NavigatorState>(),
  TabItem.artist: GlobalKey<NavigatorState>(),
};

class TabNavigatorRoutes {
  static const String home = '/';
  static const String search = '/';
  static const String library = '/';
  static const String artist = '/';
  static const String premium = '/';
  static const String settings = '//settings';
  static const String premium2 = '//premium';
  static const String discographyScreen = '//discographyScreen';
  static const String playlistScreen='//playlists_list_screen';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem, this.route});
  final String route;
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    if (tabItem == TabItem.home) {
      return {
        TabNavigatorRoutes.home: (context) => HomeScreen(),
        TabNavigatorRoutes.settings: (context) => SettingsScreen(),
        TabNavigatorRoutes.premium2: (context) => PremiumScreen(),
        TabNavigatorRoutes.playlistScreen:(context)=>PlaylistsListScreen(),
      };
    } else if (tabItem == TabItem.search) {
      return {
        TabNavigatorRoutes.search: (context) => SearchScreen(),
      };
    } else if (tabItem == TabItem.library) {
      return {
        TabNavigatorRoutes.library: (context) => LibraryScreen(),
      };
    } else if (tabItem == TabItem.premium) {
      return {TabNavigatorRoutes.premium: (context) => PremiumScreen()};
    } else {
      return {
        TabNavigatorRoutes.artist: (context) => ArtistScreen(),
        TabNavigatorRoutes.discographyScreen: (context) => ReleasesScreen()
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
      key: navigatorKey,
      initialRoute: route,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}
