//All objects concerning artist are commented until they are finalized.

//Importing libraries from external packages.
import 'package:flutter/foundation.dart';

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
  //final List<Artist> artists;

  ///A list of of strings for the copyrights of the album.
  List<String> copyrights;

  ///An list of objects containing  the url and its type of the object.
  List<ExternalUrl> externalUrls;

  ///A list of sring describing the genres of the album ex:"synthwave".
  List<String> genres;

  ///A link to the web api end point providing all details of this album{required}.
  final String href;

  ///Base 62-identifier of this object (album){required}.
  final String id;

  ///A list of url strings containig the images of the album.
  List<String> images;

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

  ///Constructor for class album with named arguments assignment.
  ///Required parameters:{href,id,name,artists,uri}.
  Album({
    ///Initializations.
    this.albumType,
    //@required this.artists,
    this.copyrights,
    this.externalUrls,
    this.genres,
    @required this.href,
    @required this.id,
    this.images,
    this.label,
    @required this.name,
    this.popularity,
    this.releaseDate,
    this.type,
    @required this.uri,
  });

  ///A method that parses a mapped object from a json file and returns an album object.
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      albumType: json['albumType'],
      //artists: json['artists'],
      copyrights: json['copyrights'],
      externalUrls: parceExternalUrl(json['externalUrls']),
      genres: json['genres'],
      href: json['href'],
      id: json['id'],
      images: json['images'],
      label: json['label'],
      name: json['name'],
      popularity: json['popularity'],
      releaseDate: json['releaseDate'],
      type: json['type'],
      uri: json['uri'],
    );
  }
}
