//Importing libraries from external packages.
import 'package:flutter/foundation.dart';
import 'package:spotify/Models/owner.dart';
import 'package:spotify/Models/track.dart';
import 'package:spotify/Providers/playlist_provider.dart';

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
  final List<Owner> owner;

  ///Boolean indicating if this playlist is public or not.
  bool public;

  ///The version identifier for the current playlist.
  String snapShotId;

  ///Refrence object to the tracks in this playlist.
  TracksRef tracksRef;

  ///List of Tracks of the playlist.
  List<Track> tracks;

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

  ///String indicating sub-category of the playlists
  PlaylistCategory category2;

  ///String that describes the the time this playlist was created at.
  String createdAt;

  ///A bool to decide either this playlist object's data is fetched or not.
  bool isFetched = false;

  ///Constructor for class playlist with named arguments assignment.
  ///Required parameters:{href,id,name,uri}.
  Playlist({
    ///Initializations.
    this.collaborative,
    this.description,
    this.externalUrls,
    this.href,
    this.id,
    this.images,
    this.name,
    this.owner,
    this.public,
    this.snapShotId,
    this.tracksRef,
    this.type,
    this.uri,
    this.popularity,
    this.noOfFollowers,
    this.category,
    this.tracks,
    this.createdAt,
  });

  ///A method that parses a mapped object from a json file and returns an Playlist object.
  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      collaborative:
          json['collaborative'] == null ? true : json['collaborative'],
      description: json['description'] == null ? null : json['description'],
      externalUrls: json['externalUrls'] == null
          ? null
          : parceExternalUrl(json['externalUrls']),
      href: json['href'] == null ? null : json['href'],
      id: json['_id'],
      images: json['images'] == null ? null : parseString(json['images']),
      name: json['name'] == null ? null : json['name'],
      owner: json['owner'] == null ? null : parceOwner(json['owner']),
      public: json['public'] == null ? true : json['public'],
      snapShotId: json['snapshot_id'] == null ? null : json['snapshot_id'],
      tracksRef:
          json['tracks'] == null ? null : TracksRef.fromJson(json['tracks']),
      type: json['type'] == null ? null : json['type'],
      uri: json['uri'] == null ? null : json['uri'],
      category: json['category'] == null ? null : json['category'],
      noOfFollowers:
          json['noOfFollowers'] == null ? null : json['noOfFollowers'],
      popularity: json['popularity'] == null ? null : json['popularity'],
      createdAt: json['createdAt'] == null ? null : json['createdAt'],
    );
  }

  ///A method that parses a mapped object from a json file and returns an Playlist object.
  factory Playlist.fromJson2(Map<String, dynamic> json) {
    return Playlist(
      collaborative:
      json['collaborative'] == null ? true : json['collaborative'],
      description: json['description'] == null ? null : json['description'],
      externalUrls: json['externalUrls'] == null
          ? null
          : parceExternalUrl(json['externalUrls']),
      href: json['href'] == null ? null : json['href'],
      id: json['_id'],
      images: json['images'] == null ? null : parseString(json['images']),
      name: json['name'] == null ? null : json['name'],
      uri: json['uri'] == null ? null : json['uri'],
      noOfFollowers:
      json['noOfFollowers'] == null ? null : json['noOfFollowers'],
      popularity: json['popularity'] == null ? null : json['popularity'],
      createdAt: json['createdAt'] == null ? null : json['createdAt'],
    );
  }

  factory Playlist.fromJson3(Map<String, dynamic> json) {
    return Playlist(
      collaborative:
      json['collaborative'] == null ? true : json['collaborative'],
      description: json['description'] == null ? null : json['description'],
      externalUrls: json['externalUrls'] == null
          ? null
          : parceExternalUrl(json['externalUrls']),
      href: json['href'] == null ? null : json['href'],
      id: json['_id'],
      images: json['images'] == null ? null : parseString(json['images']),
      name: json['name'] == null ? null : json['name'],
      uri: json['uri'] == null ? null : json['uri'],
      noOfFollowers:
      json['noOfFollowers'] == null ? null : json['noOfFollowers'],
      popularity: json['popularity'] == null ? null : json['popularity'],
      createdAt: json['createdAt'] == null ? null : json['createdAt'],
      tracksRef:
      json['tracks'] == null ? null : TracksRef.fromJson(json['tracks']),
    );
  }


}
