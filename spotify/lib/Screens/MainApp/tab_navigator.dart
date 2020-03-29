import 'package:flutter/material.dart';
import 'package:spotify/Screens/MainApp/artist_screen.dart';
import 'package:spotify/Screens/MainApp/library_screen.dart';
import 'package:spotify/Screens/MainApp/premium_screen.dart';
import './bottom_navigation_bar.dart';
import './home_screen.dart';
import './setting_screen.dart';
import './search_screen.dart';

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
  } 
class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem, this.route});
  final String route;
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  // void _push(BuildContext context, {int materialIndex: 500}) {
  //   var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) =>
  //           routeBuilders[TabNavigatorRoutes.settings](context),
  //     ),
  //   );
  // }
   

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
          
          ),

    };
  }
  Map<String, WidgetBuilder> _routeBuilders3(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.search: (context) => LibraryScreen(
          ),
     
    };
  }
   Map<String, WidgetBuilder> _routeBuilders4(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.search: (context) => PremiumScreen(
 
          ),
     
    };
  }
   Map<String, WidgetBuilder> _routeBuilders5(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.search: (context) => ArtistScreen(
         
          ),

    };
  }
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
