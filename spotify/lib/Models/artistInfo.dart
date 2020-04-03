import 'package:spotify/utilities.dart';


class ArtistInfo {
  final String biography;
  final String popularity;
  final List<String> genres;
  ArtistInfo({
    this.biography,
    this.popularity,
    this.genres,
  });
  factory ArtistInfo.fromJson(Map<String, dynamic> json) {
    return ArtistInfo(
      biography: json['biography'] ,
      popularity: json['popularity'],
      genres : parseString(json['genres']),
    );
  }
}
