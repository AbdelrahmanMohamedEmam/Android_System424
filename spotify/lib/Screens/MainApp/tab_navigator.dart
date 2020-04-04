import 'package:flutter/material.dart';
import 'package:spotify/Screens/ArtistMode/add_album_screen.dart';
import 'package:spotify/Screens/MainApp/Settings/change_password_screen.dart';
import 'package:spotify/Screens/MainApp/Settings/profile_screen.dart';
import 'package:spotify/Screens/MainApp/artist_screen.dart';
import 'package:spotify/Screens/MainApp/library_screen.dart';
import 'package:spotify/Screens/MainApp/premium_screen.dart';
import '../../widgets/bottom_navigation_bar.dart';
import './home_screen.dart';
import './Settings/setting_screen.dart';
import './search_screen.dart';
import '../ArtistProfile/see_discography_screen.dart';
import '../Playlists/playlists_list_screen.dart';
import '../Albums/albums_list_screen.dart';
import '../MainApp/Settings/user_playlists_screen.dart';
import '../MainApp/Settings/user_followers_screen.dart';
import '../MainApp/Settings/user_followings_screen.dart';
import '../MainApp/Settings/user_edit_profile_screen.dart';
import '../../Screens/ArtistMode/my_music_screen.dart';
import '../../Screens/ArtistMode/add_album_screen.dart';
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
  static const String albumScreen='//albums_list_screen';
  static const String profileScreen = '//profileScreen';
  static const String userPlaylistsScreen = '//userPlaylistsScreen';
  static const String userFollowersScreen = '//userFollowersScreen';
  static const String userFollowingScreen = '//userFollowingScreen';
  static const String userEditProfileScreen = '//userEditProfileScreen';
  static const String changePasswordScreen = '//changePasswordScreen';
  static const String myMusicScreen = '//my_music_screen';
  static const String addAlbumScreen = '//add_album_screen';
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
        TabNavigatorRoutes.albumScreen:(context)=>AlbumsListScreen(),
        TabNavigatorRoutes.profileScreen: (context) => ProfileScreen(),
        TabNavigatorRoutes.userPlaylistsScreen: (context) =>
            UserPlaylistsScreen(),
        TabNavigatorRoutes.userFollowersScreen: (context) =>
            UserFollowersScreen(),
        TabNavigatorRoutes.userFollowingScreen: (context) =>
            UserFollowingScreen(),
        TabNavigatorRoutes.userEditProfileScreen: (context) =>
            UserEditProfileScreen(),
        TabNavigatorRoutes.changePasswordScreen: (context) =>
            ChangePasswordScreen(),
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
        TabNavigatorRoutes.discographyScreen: (context) => ReleasesScreen(),
        TabNavigatorRoutes.myMusicScreen: (context) => MyMusicScreen(),
        TabNavigatorRoutes.addAlbumScreen: (context) =>CreateAlbum(),
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
