import 'package:flutter/material.dart';
import 'package:spotify/Screens/Library/artists_screen.dart';
import 'package:spotify/Screens/MainApp/artist_screen.dart';
import 'package:spotify/Screens/MainApp/library_screen.dart';
import 'package:spotify/Screens/MainApp/premium_screen.dart';
import './bottom_navigation_bar.dart';
import './home_screen.dart';
import './setting_screen.dart';
import './search_screen.dart';
import './tabs_screen.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem, this.route});
  final String route;
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context, {int materialIndex: 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[TabNavigatorRoutes.settings](context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.home: (context) => HomeScreen(),

      TabNavigatorRoutes.settings: (context) => SettingsScreen(),
       TabNavigatorRoutes.premium2: (context) => PremiumScreen(),
    };
  }

  Map<String, WidgetBuilder> _routeBuilders2(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.search: (context) => SearchScreen(
          // onPush: (materialIndex) =>
          //     _push(context, materialIndex: materialIndex),
          ),
      //TabNavigatorRoutes.search: (context) => SearchScreen(),
      //TabNavigatorRoutes.library: (context) => LibraryScreen(),
      // TabNavigatorRoutes.premium: (context) => PremiumScreen(),
      // TabNavigatorRoutes.artist: (context) => ArtistScreen(),
      //TabNavigatorRoutes.settings: (context) => SettingsScreen(),
    };
  }
  Map<String, WidgetBuilder> _routeBuilders3(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.search: (context) => LibraryScreen(
          // onPush: (materialIndex) =>
          //     _push(context, materialIndex: materialIndex),
          ),
      //TabNavigatorRoutes.search: (context) => SearchScreen(),
      //TabNavigatorRoutes.library: (context) => LibraryScreen(),
      // TabNavigatorRoutes.premium: (context) => PremiumScreen(),
      // TabNavigatorRoutes.artist: (context) => ArtistScreen(),
      //TabNavigatorRoutes.settings: (context) => SettingsScreen(),
    };
  }
   Map<String, WidgetBuilder> _routeBuilders4(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.search: (context) => PremiumScreen(
          // onPush: (materialIndex) =>
          //     _push(context, materialIndex: materialIndex),
          ),
      //TabNavigatorRoutes.search: (context) => SearchScreen(),
      //TabNavigatorRoutes.library: (context) => LibraryScreen(),
      // TabNavigatorRoutes.premium: (context) => PremiumScreen(),
      // TabNavigatorRoutes.artist: (context) => ArtistScreen(),
      //TabNavigatorRoutes.settings: (context) => SettingsScreen(),
    };
  }
   Map<String, WidgetBuilder> _routeBuilders5(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.search: (context) => ArtistScreen(
          // onPush: (materialIndex) =>
          //     _push(context, materialIndex: materialIndex),
          ),
      //TabNavigatorRoutes.search: (context) => SearchScreen(),
      //TabNavigatorRoutes.library: (context) => LibraryScreen(),
      // TabNavigatorRoutes.premium: (context) => PremiumScreen(),
      // TabNavigatorRoutes.artist: (context) => ArtistScreen(),
      //TabNavigatorRoutes.settings: (context) => SettingsScreen(),
    };
  }

  // String myRoute(TabItem tabItem) {
  //   if (tabItem == TabItem.home) {
  //     return TabNavigatorRoutes.home;
  //    } //else if (tabItem == TabItem.search) {
  //   //   return TabNavigatorRoutes.search;
  //   // } else if (tabItem == TabItem.library) {
  //   //   return TabNavigatorRoutes.library;
  //   // } else if (tabItem == TabItem.premium) {
  //   //   return TabNavigatorRoutes.premium;
  //   // } else {
  //   //   return TabNavigatorRoutes.artist;
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    var routeBuilders;
    if (tabItem == TabItem.home) {
      routeBuilders = _routeBuilders(context);
    } else if(tabItem==TabItem.search) {
      routeBuilders = _routeBuilders2(context);
    }
    else if(tabItem==TabItem.library)
    {
      routeBuilders = _routeBuilders3(context);
    }
    else if(tabItem==TabItem.premium)
    {
      routeBuilders = _routeBuilders4(context);
    }
    else
    {
      routeBuilders = _routeBuilders5(context);
    }
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
