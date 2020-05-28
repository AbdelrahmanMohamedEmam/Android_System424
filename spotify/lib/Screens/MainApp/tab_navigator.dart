//Importing libraries from external packages.
import 'package:flutter/material.dart';
//Importing Screens
import 'package:spotify/Screens/ArtistMode/add_album_screen.dart';
import 'package:spotify/Screens/ArtistMode/edit_song.dart';
import 'package:spotify/Screens/ArtistMode/edit_album_screen.dart';
import 'package:spotify/Screens/MainApp/Settings/change_password_screen.dart';
import 'package:spotify/Screens/MainApp/Settings/profile_screen.dart';
import 'package:spotify/Screens/MainApp/artist_screen.dart';
import 'package:spotify/Screens/MainApp/library_screen.dart';
import 'package:spotify/Screens/MainApp/premium_screen.dart';
import 'package:spotify/Screens/MainApp/recent_activities_screen.dart';
import 'package:spotify/Screens/MainApp/search_screen_see_all.dart';
import '../../Screens/ArtistMode/my_music_screen.dart';
import '../../Screens/ArtistMode/add_album_screen.dart';
import '../../Screens/ArtistMode/add_song_screen.dart';
import './home_screen.dart';
import '../Albums/albums_list_screen.dart';
import '../MainApp/Settings/user_playlists_screen.dart';
import '../MainApp/Settings/user_followers_screen.dart';
import '../MainApp/Settings/user_followings_screen.dart';
import '../MainApp/Settings/user_edit_profile_screen.dart';
import './Settings/setting_screen.dart';
import './search_screen.dart';
import '../ArtistProfile/see_discography_screen.dart';
import 'Settings/recently_played_artists_screen.dart';
import '../ArtistProfile/about_info_screen.dart';
import '../ArtistMode/edit_album_screen.dart';
import '../ArtistMode/stats_screen.dart';
//Importing widgets.
import '../../widgets/bottom_navigation_bar.dart';

///A map of [TabItem] and a [GlobalKey] with [NavigatorState].
Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
  TabItem.home: GlobalKey<NavigatorState>(),
  TabItem.search: GlobalKey<NavigatorState>(),
  TabItem.library: GlobalKey<NavigatorState>(),
  TabItem.premium: GlobalKey<NavigatorState>(),
  TabItem.artist: GlobalKey<NavigatorState>(),
};

///Class Tab navigator routes for nested navigator route names.
class TabNavigatorRoutes {
  static const String home = '/';
  static const String search = '/';
  static const String library = '/';
  static const String artist = '/';
  static const String premium = '/';
  static const String settings = '//settings';
  static const String premium2 = '//premium';
  static const String discographyScreen = '//discographyScreen';
  static const String playlistScreen = '//playlists_list_screen';
  static const String albumScreen = '//albums_list_screen';
  static const String profileScreen = '//profileScreen';
  static const String userPlaylistsScreen = '//userPlaylistsScreen';
  static const String userFollowersScreen = '//userFollowersScreen';
  static const String userFollowingScreen = '//userFollowingScreen';
  static const String userEditProfileScreen = '//userEditProfileScreen';
  static const String changePasswordScreen = '//changePasswordScreen';
  static const String recentlyPlayedArtistsScreen =
      '//recentlyPlayedArtistsScreen';
  static const String recentActivitiesScreen = '//recentActivitiesScreen';
  static const String myMusicScreen = '//my_music_screen';
  static const String addAlbumScreen = '//add_album_screen';
  static const String addSongScreen = '//add_song_screen';
  static const String editAlbumScreen = '//edit_album_screen';
  static const String aboutInfoScreen = '//about_screen';
  static const String searchAll = '//searchAll';
  static const String statsScreen = '//stats_screen';
  static const String artistSongsScreen ='//artist_slbums_songs_screen';
  static const String editSongsScreen ='//edit_song_screen';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem, this.route});

  ///String has an initial route to the tab.
  final String route;

  ///GlobalKey to identify this tab.
  final GlobalKey<NavigatorState> navigatorKey;

  ///Tab item value to identify the [TabItem] for this Navigator.
  final TabItem tabItem;

  ///A method that returns a map of [String] and [WidgetBuilder] to build the nested root.
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    if (tabItem == TabItem.home) {
      return {
        TabNavigatorRoutes.home: (context) => HomeScreen(),
        TabNavigatorRoutes.settings: (context) => SettingsScreen(),
        TabNavigatorRoutes.premium2: (context) => PremiumScreen(),
        TabNavigatorRoutes.albumScreen: (context) => AlbumsListScreen(),
        TabNavigatorRoutes.profileScreen: (context) => ProfileScreen(),
        TabNavigatorRoutes.userPlaylistsScreen: (context) =>
            UserPlaylistsScreen(),
        // TabNavigatorRoutes.userFollowersScreen: (context) =>
        //     UserFollowersScreen(),
        TabNavigatorRoutes.userFollowingScreen: (context) =>
            UserFollowingScreen(),
        TabNavigatorRoutes.userEditProfileScreen: (context) =>
            UserEditProfileScreen(),
        TabNavigatorRoutes.changePasswordScreen: (context) =>
            ChangePasswordScreen(),
        TabNavigatorRoutes.recentlyPlayedArtistsScreen: (context) =>
            RecentlyPlayedArtistsScreen(),
        TabNavigatorRoutes.recentActivitiesScreen: (context) =>
            RecentActivitiesScreen(),
      };
    } else if (tabItem == TabItem.search) {
      return {
        TabNavigatorRoutes.search: (context) => SearchScreen(),
        TabNavigatorRoutes.searchAll: (context) => SearchScreenSeeAll(),
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
        TabNavigatorRoutes.addAlbumScreen: (context) => CreateAlbum(),
        TabNavigatorRoutes.addSongScreen: (context) => AddSongScreen(),
        TabNavigatorRoutes.aboutInfoScreen: (context) => AboutScreen(),
        TabNavigatorRoutes.editAlbumScreen: (context) => EditAlbum(),
        TabNavigatorRoutes.statsScreen: (context) => StatsScreen(),
        TabNavigatorRoutes.editSongsScreen: (context) => EditSongScreen(),
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
