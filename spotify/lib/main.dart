///Import dart and flutter libraries to use.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:spotify/Providers/categories_provider.dart';

///Import providers.
import 'package:spotify/Providers/playable_track.dart';
import 'package:spotify/Screens/MainApp/Settings/change_password_screen.dart';
import 'Providers/play_history_provider.dart';
import 'Providers/user_provider.dart';
import 'Providers/playlist_provider.dart';
import 'Providers/album_provider.dart';
import './Providers/artist_provider.dart';

///Importing screens to add paths.
import 'Screens/MainApp/artist_screen.dart';
import 'Screens/MainApp/home_screen.dart';
import 'Screens/MainApp/library_screen.dart';
import 'Screens/MainApp/premium_screen.dart';
import 'Screens/MainApp/search_screen.dart';
import 'Screens/SignUpAndLogIn/add_birthdate_screen.dart';
import 'Screens/SignUpAndLogIn/check_email_screen.dart';
import 'Screens/SignUpAndLogIn/choose_gender_screen.dart';
import 'Screens/SignUpAndLogIn/choose_name_screen.dart';
import 'Screens/SignUpAndLogIn/create_email_screen.dart';
import 'Screens/SignUpAndLogIn/create_password_screen.dart';
import 'Screens/SignUpAndLogIn/forgot_password_email_screen.dart';
import 'Screens/SignUpAndLogIn/logIn_screen.dart';
import 'Screens/ArtistProfile/see_discography_screen.dart';
import 'Screens/ArtistProfile/about_info_screen.dart';
import 'Screens/ArtistProfile/song_promo_screen.dart';
import 'package:spotify/Screens/ArtistMode/manage_profile_screen.dart';
import 'package:spotify/Screens/ArtistMode/my_music_screen.dart';
import 'package:spotify/Screens/ArtistMode/overview_screen.dart';
import 'package:spotify/Screens/ArtistMode/stats_screen.dart';
import 'package:spotify/Screens/ArtistMode/add_song_screen.dart';
import 'package:spotify/Screens/MainApp/splash_Screen.dart';
import 'package:spotify/Screens/SignUpAndLogIn/choose_fav_artists.screen.dart';
import 'package:spotify/Screens/SignUpAndLogIn/intro_screen.dart';
import 'package:spotify/Widgets/trackPlayer.dart';
import './Providers/track_provider.dart';
///A Function to read the configuration file before running the app.
Future<String> setUrl() async {
  String content = await rootBundle.loadString("assets/config.txt");
  final option = content.substring(14, 15);
  if (option == '2') {
    return 'http://spotify.mocklab.io';
  } else if (option == '1') {
    return 'http://138.91.114.14/api';
  }
}

void main() async {
  ///Setting the API url before running the app.
  WidgetsFlutterBinding.ensureInitialized();
  String url = await setUrl();

  runApp(Phoenix(
      child: MyApp(
    url: url,
  )));
}

class MyApp extends StatelessWidget {
  ///API url.
  final String url;

  ///Constructor.
  MyApp({this.url});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProvider(
            baseUrl: url,
            context: context,
          ),
        ),
        ChangeNotifierProvider.value(
          value: TrackProvider(baseUrl: url),
        ),
        ChangeNotifierProvider.value(
          value: PlaylistProvider(baseUrl: url),
        ),
        ChangeNotifierProvider.value(
          value: AlbumProvider(baseUrl: url),
        ),
        ChangeNotifierProvider.value(
          value: ArtistProvider(baseUrl: url),
        ),
        ChangeNotifierProvider.value(
          value: PlayableTrackProvider(baseUrl: url),
        ),
        ChangeNotifierProvider.value(
          value: PlayHistoryProvider(baseUrl: url),
        ),
        ChangeNotifierProvider.value(
          value: CategoriesProvider(baseUrl: url),
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
            CreatePasswordScreen.routeName: (ctx) => CreatePasswordScreen(),
            ChooseFavArtists.routeName: (ctx) => ChooseFavArtists(),
            ReleasesScreen.routeName: (ctx) => ReleasesScreen(),
            AboutScreen.routeName: (ctx) => AboutScreen(),
            MainWidget.routeName: (ctx) => MainWidget(),
            IntroScreen.routeName: (ctx) => IntroScreen(),
            SplashScreen.routeName: (ctx) => SplashScreen(),
            ManageProfileScreen.routeName: (ctx) => ManageProfileScreen(),
            OverviewScreen.routeName: (ctx) => OverviewScreen(),
            StatsScreen.routeName: (ctx) => StatsScreen(),
            MyMusicScreen.routeName: (ctx) => MyMusicScreen(),
            AddSongScreen.routeName: (ctx) => AddSongScreen(),
          },
        ),
      ),
    );
  }
}
