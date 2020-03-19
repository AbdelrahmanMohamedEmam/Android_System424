//Importing libraries from external packages.
import 'package:flutter/foundation.dart';

//Import Models.
import './external_url.dart';
import '../utilities.dart';
import './tracks_ref.dart';

///Class Playlist.
class Playlist with ChangeNotifier {
  ///Boolean indicated that the user could modify this object or not.
  bool collaborative;

  ///String with the names of the artists int the playlists.
  String description;

  ///An list of objects containing  the url and its type of the object.
  List<ExternalUrl> externalUrls;

  ///A link to the web api end point providing all details of this playlist{required}.
  final String href;

  ///Base 62-identifier of this object (playlist){required}.
  final String id;

  ///List of string urls for the images of the playlist.
  List<String> images;

  ///The name of the playlist{required}.
  final String name;

  ///List of strings for the href of the owners of the playlist.
  final List<String> owner;

  ///Boolean indicating if this playlist is public or not.
  bool public;

  ///The version identifier for the current playlist.
  String snapShotId;

  ///Refrence object to the tracks in this playlist.
  TracksRef tracks;

  ///The type of this playlist.
  String type;

  ///The spotify uri for this playlist{required}.
  final String uri;

  ///A number describing the total number of likes of its individual tracks.
  int popularity;

  ///A number describing the total number of followers for this playlist.
  int noOfFollowers;

  ///String indicating the category of the playlist.
  String category;

  ///Constructor for class playlist with named arguments assignment.
  ///Required parameters:{href,id,name,uri}.
  Playlist({
    ///Initializations.
    this.collaborative,
    this.description,
    this.externalUrls,
    /*@required*/ this.href,
    /*@required*/ this.id,
    this.images,
    /*@required*/ this.name,
    /*@required*/ this.owner,
    this.public,
    this.snapShotId,
    this.tracks,
    this.type,
    /*@required*/ this.uri,
    this.popularity,
    this.noOfFollowers,
    this.category,
  });
  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      //collaborative: json['collaborative'],
      description: json['description'],
      //externalUrls: parceExternalUrl(json['externalUrls']),
      //href: json['href'],
      //id: json['id'],
      images: parseString(json['images']),
      //name: json['name'],
      //owner: json['owner'],
      //public: json['public'],
      //snapShotId: json['snapshot_id'],
      //tracks: TracksRef.fromJson(json['tracks']),
      //type: json['type'],
      //uri: json['uri'],
      //category: json['category'],
      //noOfFollowers: json['noOfFollowers'],
      //popularity: json['popularity'],
    );
  }
}
