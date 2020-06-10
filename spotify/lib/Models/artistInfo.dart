import 'package:spotify/utilities.dart';

///Artist Info model (used to parse biography , popularity , genres
///attributes to be set in artist)
class ArtistInfo {
  ///A string describing the biography of the artist.
  final String biography;

  ///A string describing the popularity of the artist.
  final int popularity;

  ///List of strings of genres of the artist.
  final List<String> genres;

  ///Constructor for class Artist with named arguments assignment.
  ArtistInfo({
    ///Initializations.
    this.biography,
    this.popularity,
    this.genres,
  });

  ///A method that parses a mapped object from a json file and returns an Artist object.
  factory ArtistInfo.fromJson(Map<String, dynamic> json) {
    return ArtistInfo(
      biography: json['biography']==null?"" : json['biography'] ,
      popularity: json['popularity']==null?"" : json['popularity'],
      genres: parseString(json['genres']),
    );
  }
}
