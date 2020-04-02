
import 'package:flutter/foundation.dart';
import 'package:spotify/Models/artistInfo.dart';
import './external_url.dart';
//need to import something for followers
import './follower.dart';
//need to import something for genres
import '../Models/image.dart';
import '../utilities.dart';

class Artist with ChangeNotifier{
  final String externalUrls;
  final Follower followers;
  //final List<String> genres;
  final String href;
  final String id;
  final List<Image> images;
  final String name;
  //final int  popularity;
  final String type;
  final String uri;
  final ArtistInfo artistInfo;

  //final String bio;

  Artist({
    this.externalUrls,
    this.followers,
    //this.genres,
    this.href,
    this.id,
    this.images,
    this.name ,
    //this.popularity ,
    this.type ,
    this.uri ,
    //this.bio
    this.artistInfo,

  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    print(json['artistInfo']);
    return Artist(
      externalUrls: json['externalUrls'],
      followers: Follower.fromjson(json['followers']),
      //genres: json['genres'],
      href: json['href'],
      id: json['id'],
      images: parceImage(json['images']),
      name: json['name'],
      //popularity: json['popularity'],
      type: json['type'],
      uri: json['uri'],
      //bio: json['bio'],
      artistInfo: ArtistInfo.fromJson(json['artistInfo']),
    );

  }
  factory Artist.fromJsonSimplified(Map<String, dynamic> json) {
    return Artist(
      //id: json['id'],
      name: json['name'],
      href: json['href'],
      type: json['type'],
      //externalUrls: parceExternalUrl(json['externalUrls']),
      uri: json['uri'],
      //popularity: json['popularity'],
    );
  }
}
