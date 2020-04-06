//Import Packages
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:spotify/Screens/ArtistMode/add_song_screen.dart';
import 'package:spotify/Screens/SignUpAndLogIn/choose_fav_artists.screen.dart';
import 'package:spotify/Screens/SignUpAndLogIn/intro_screen.dart';
import 'package:spotify/Widgets/premium_card.dart';
import 'package:charts_flutter/flutter.dart';

import 'package:spotify/Providers/playable_track.dart';
import 'package:spotify/Screens/MainApp/splash_Screen.dart';
import 'package:spotify/Screens/SignUpAndLogIn/choose_fav_artists.screen.dart';
import 'package:spotify/Screens/SignUpAndLogIn/intro_screen.dart';
import 'package:spotify/Screens/Song/song_screen.dart';
import 'package:spotify/Widgets/trackPlayer.dart';


//Import Providers
import 'Providers/play_history_provider.dart';
import 'Providers/user_provider.dart';
import 'Providers/playlist_provider.dart';
import 'Providers/album_provider.dart';

//Import Screens
import 'Screens/MainApp/artist_screen.dart';
import 'Screens/MainApp/home_screen.dart';
import 'Screens/MainApp/library_screen.dart';
import 'Screens/MainApp/premium_screen.dart';
import 'Screens/MainApp/search_screen.dart';

//import 'Screens/ArtistProfile/';
import 'Screens/ArtistProfile/see_discography_screen.dart';
import 'Screens/ArtistProfile/about_info_screen.dart';
import 'Screens/ArtistProfile/song_promo_screen.dart';
import 'package:spotify/Screens/ArtistMode/add_song_screen.dart';
//import 'Screens/ArtistMode/';
import 'package:spotify/Screens/ArtistMode/manage_profile_screen.dart';
import 'package:spotify/Screens/ArtistMode/my_music_screen.dart';
import 'package:spotify/Screens/ArtistMode/overview_screen.dart';
import 'package:spotify/Screens/ArtistMode/stats_screen.dart';
//import 'Screens/MainApp/splash_Screen.dart';

import 'Screens/ArtistProfile/see_discography_screen.dart';
import 'Screens/ArtistProfile/about_info_screen.dart';
import 'Screens/ArtistProfile/song_promo_screen.dart';
import 'Screens/SignUpAndLogIn/add_birthdate_screen.dart';
import 'Screens/SignUpAndLogIn/check_email_screen.dart';
import 'Screens/SignUpAndLogIn/choose_gender_screen.dart';
import 'Screens/SignUpAndLogIn/choose_name_screen.dart';
import 'Screens/SignUpAndLogIn/create_email_screen.dart';
import 'Screens/SignUpAndLogIn/create_password_screen.dart';
import 'Screens/SignUpAndLogIn/forgot_password_email_screen.dart';
import 'Screens/SignUpAndLogIn/logIn_screen.dart';
import './Providers/artist_provider.dart';

void main() async {
  String mockUrl = 'https://b13325a9-1802-4805-ad26-6026c3b3eda3.mock.pstmn.io';
  String url;
  runApp(
    Phoenix(child: MyApp(url: mockUrl)),
  );
}

class MyApp extends StatelessWidget {
  final String url;
  MyApp({this.url});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProvider(baseUrl: url),
        ),
        ChangeNotifierProvider.value(
          value: PlaylistProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AlbumProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ArtistProvider(),
        ),
        ChangeNotifierProvider.value(
          value: PlayableTrackProvider(),
        ),
        ChangeNotifierProvider.value(
          value: PlayHistoryProvider(),
        )
      ],
      child: Consumer<UserProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Spotify',
          theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.black,
            fontFamily: 'Lineto',
          ),

          //home: IntroScreen(),
          //home: SplashScreen(),
          home: SplashScreen(),
          routes: {
            CreateEmailScreen.routeName: (ctx) => CreateEmailScreen(),
            CreatePasswordScreen.routeName: (ctx) => CreatePasswordScreen(),
            AddBirthDateScreen.routeName: (ctx) => AddBirthDateScreen(),
            ChooseGenderScreen.routeName: (ctx) => ChooseGenderScreen(),
            ChooseNameScreen.routeName: (ctx) => ChooseNameScreen(),
            LogInScreen.routeName: (ctx) => LogInScreen(),
            GetEmailScreen.routeName: (ctx) => GetEmailScreen(),
            CheckEmailScreen.routeName: (ctx) => CheckEmailScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            SearchScreen.routeName: (ctx) => SearchScreen(),
            LibraryScreen.routeName: (ctx) => LibraryScreen(),
            PremiumScreen.routeName: (ctx) => PremiumScreen(),
            ArtistScreen.routeName: (ctx) => ArtistScreen(),
            ChooseFavArtists.routeName: (ctx) => ChooseFavArtists(),
            ReleasesScreen.routeName: (ctx) => ReleasesScreen(),
            AboutScreen.routeName: (ctx) => AboutScreen(),
            SongPromoScreen.routeName: (ctx) => SongPromoScreen(),
            CreatePasswordScreen.routeName: (ctx) => CreatePasswordScreen(),
            ChooseFavArtists.routeName: (ctx) => ChooseFavArtists(),
            ReleasesScreen.routeName: (ctx) => ReleasesScreen(),
            AboutScreen.routeName: (ctx) => AboutScreen(),
            SongPromoScreen.routeName: (ctx) => SongPromoScreen(),
            MainWidget.routeName: (ctx) => MainWidget(),
            IntroScreen.routeName: (ctx) => IntroScreen(),
            SplashScreen.routeName: (ctx) => SplashScreen(),
            ManageProfileScreen.routeName : (ctx) => ManageProfileScreen(),
            OverviewScreen.routeName : (ctx) => OverviewScreen(),
            StatsScreen.routeName : (ctx) => StatsScreen(),
            MyMusicScreen.routeName : (ctx) => MyMusicScreen(),
            AddSongScreen.routeName : (ctx) => AddSongScreen(),
          },
        ),
      ),
    );
  }
}
