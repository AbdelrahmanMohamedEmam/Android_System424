import 'package:flutter/foundation.dart';
import 'package:spotify/Models/artistInfo.dart';
import '../utilities.dart';

///Album class.
class Artist with ChangeNotifier {
  ///An list of objects containing  the url and its type of the object.
  final List<String> externalUrls;

  ///List of strings describing followers.
  final List<String> followers;

  ///A link to the web api end point providing all details of this artist{required}.
  final String href;

  ///Base 62-identifier of this object (artist){required}.
  final String id;

  ///List of strings containing images of artist with different sizes.
  final List<String> images;

  ///A string describing artist's name.
  final String name;

  ///A string describing the type of the artist.
  final String type;

  ///A string describing the spotify uri for this artist{required}.
  final String uri;

  ///A string describing [biography],[popularity],[genres] of the artist.
  final ArtistInfo artistInfo;

  ///Constructor for class Artist with named arguments assignment.
  ///Required parameters:{href,id,name,artistInfo,uri}.
  Artist(
      {

      ///Initializations.
      this.externalUrls,
      this.followers,
      this.href,
      this.id,
      this.images,
      this.name,
      this.type,
      this.uri,
      this.artistInfo});

  ///A method that parses a mapped object from a json file and returns an Artist object.
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      externalUrls: parseString(json['externalUrls']),
      followers: parseString(json['followers']),
      href: json['href'],
      id: json['_id'],
      images: parseString(json['images']),
      name: json['name']==null?"": json['name'],
      //type: json['role'],
      uri: json['uri'],
      //artistInfo: ArtistInfo.fromJson(json['artistInfo']),
    );
  }

  ///A method that parses a mapped object from a json file and returns an Artist Simplified object.
  factory Artist.fromJsonSimplified(Map<String, dynamic> json) {
    return Artist(
      name: json['name'],
      href: json['href'],
      type: json['type'],
      uri: json['uri'],
    );
  }
}
