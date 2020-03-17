//Import Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Screens/SignUpAndLogIn/choose_fav_artists.screen.dart';
import 'package:spotify/Screens/SignUpAndLogIn/intro_screen.dart';
import 'package:spotify/Widgets/premium_card.dart';

//Import Providers
import 'Providers/user_provider.dart';
import 'Providers/playlist_provider.dart';

//Import Screens
import 'Screens/MainApp/artist_screen.dart';
import 'Screens/MainApp/home_screen.dart';
import 'Screens/MainApp/library_screen.dart';
import 'Screens/MainApp/premium_screen.dart';
import 'Screens/MainApp/search_screen.dart';
//import 'Screens/MainApp/splash_Screen.dart';
import 'Screens/SignUpAndLogIn/add_birthdate_screen.dart';
import 'Screens/SignUpAndLogIn/check_email_screen.dart';
import 'Screens/SignUpAndLogIn/choose_gender_screen.dart';
import 'Screens/SignUpAndLogIn/choose_name_screen.dart';
import 'Screens/SignUpAndLogIn/create_email_screen.dart';
import 'Screens/SignUpAndLogIn/create_password_screen.dart';
import 'Screens/SignUpAndLogIn/forgot_password_email_screen.dart';
import 'Screens/SignUpAndLogIn/logIn_screen.dart';
//import 'Screens/SignUpAndLogIn/intro_screen.dart';
import 'Screens/MainApp/tabs_screen.dart';
import 'Widgets/fav_artist_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: UserProvider(),
          ),
          ChangeNotifierProvider.value(
            value: PlaylistProvider(),
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

                  home: IntroScreen(), // auth.isAuth
                  //     ? HomeScreen()
                  //     : /*FutureBuilder(
                  //         future: auth.tryAutoLogin(),
                  //         builder: (ctx, authResultSnapshot) =>*/
                  //                 IntroScreen(),
                  //),
                  //home:SplashScreen(),
                  //home: TabsScreen(),
                  routes: {
                    CreateEmailScreen.routeName: (ctx) => CreateEmailScreen(),
                    CreatePasswordScreen.routeName: (ctx) =>
                        CreatePasswordScreen(),
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
                  },
                )));
  }
}
