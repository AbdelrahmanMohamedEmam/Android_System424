import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/Screens/ArtistProfile/artist_profile_screen.dart';
import '../../spotify/lib/Providers/album_provider.dart';
import 'package:flutter/material.dart';
import '../lib/Screens/ArtistProfile/artist_profile_screen.dart';
import '../lib/Screens/MainApp/artist_screen.dart';

/*class MockClient extends Mock implements AlbumProvider{}
main() {
  Widget makeTestableWidget({Widget child,AlbumProvider  album}) {
    return ArtistScreen(
      key: ,
      auth: album,
      child: MaterialApp(
        home: child,
      ),
    );
  }


  // Tests go here
}*/