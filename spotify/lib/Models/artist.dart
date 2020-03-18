
import './external_url.dart';
//need to import something for followers
import './follower.dart';
//need to import something for genres
import './image.dart';
import '../utilities.dart';

class Artist {
  final List<ExternalUrl> externalUrls;
  final List<Follower> followers;
  final List<String> genres;
  final String href;
  final String id;
  final List<Image> images;
  final String name;
  final int popularity;
  final String type;
  final String uri;
  //final String bio;


  Artist({
    this.externalUrls ,
    this.followers ,
    this.genres ,
    this.href ,
    this.id,
    this.images,
    this.name ,
    this.popularity ,
    this.type ,
    this.uri ,
   // this.bio ,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      externalUrls: parceExternalUrl(json['externalUrls']),
      followers :  parceFollower(json['followers']),
      genres:  json['genres'],
      href: json['href'],
      id: json['id'],
      images: parceImage(json['images']),
      name: json['name'],
      popularity: json['popularity'],
      type: json['type'],
      uri: json['uri'],
      //bio: json['bio'],
    );
  }
}
