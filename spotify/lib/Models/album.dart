//All objects concerning artist are commented until they are finalized.

//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:spotify/Models/artist.dart';
import 'package:spotify/Models/track.dart';

//Import model files.
import '../Models/external_url.dart';
//import '../Models/artist.dart';

//Import utilities file.
import '../utilities.dart';

///Album class.
class Album with ChangeNotifier {
  ///The type of the album sent ex:"single".
  String albumType;

  ///A list of artist objects. the artists of the album {required}.
  final List<Artist> artists;

  ///A list of of strings for the copyrights of the album.
  List<String> copyrights;

  ///An list of objects containing  the url and its type of the object.
  List<String> externalUrls;

  ///A list of sring describing the genres of the album ex:"synthwave".
  List<String> genres;

  ///A link to the web api end point providing all details of this album{required}.
  final String href;

  ///Base 62-identifier of this object (album){required}.
  final String id;

  ///A list of url strings containig the images of the album.
  List<String> images;

  String image;

  ///String describing the label of the album.
  String label;

  ///The name of the album{required}.
  final String name;

  ///A number describing the total number of likes of its individual tracks.
  int popularity;

  ///A string to describe the release date of the album, it might be in yyyy-mm format or yyyy-mm-dd.
  String releaseDate;

  ///A string describing the type of the album ex: "album".
  String type;

  ///The spotify uri for this album{required}.
  final String uri;

  final int totalTracks;

  List<Track> tracks;

  bool isFetched = false;

  ///Constructor for class album with named arguments assignment.
  ///Required parameters:{href,id,name,artists,uri}.
  Album({
    ///Initializations.
    this.albumType,
    this.artists,
    this.copyrights,
    this.externalUrls,
    this.genres,
    this.href,
    this.id,
    this.images,
    this.image,
    this.label,
    this.name,
    this.popularity,
    this.releaseDate,
    this.type,
    this.uri,
    this.totalTracks,
    this.tracks,
  });

  ///A method that parses a mapped object from a json file and returns an album object.
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      albumType: json['albumType'] == null ? "" : json['albumType'],
      // //artists: json['artists'] == null ? null : json['artists'],
      copyrights:
          json['copyrights'] == null ? [] : parseString(json['copyrights']),
      externalUrls:
          json['externalUrls'] == null ? [] : parseString(json['externalUrls']),
      genres: json['genres'] == null ? [] : parseString(json['genres']),
      href: json['href'] == null ? "" : json['href'],
      id: json['_id'] == null ? "" : json['_id'],
      images: json['images'] == null ? [] : parseString(json['images']),
      image: json['image'] == null ? "" : json['image'],
      label: json['label'] == null ? "" : json['label'],
      name: json['name'] == null ? "" : json['name'],
      popularity: json['popularity'] == null ? 0 : json['popularity'],
      releaseDate: json['releaseDate'] == null ? "" : json['releaseDate'],
      type: json['type'] == null ? "" : json['type'],
      uri: json['uri'] == null ? "" : json['uri'],
      totalTracks: json['total_tracks'] == null ? 0 : json['total_tracks'],
    );
  }
}
