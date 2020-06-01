import './user_stats.dart';
import './external_url.dart';
import '../utilities.dart';

///Class Owner that describes the owner object.
class Owner {
  ///The unique identifier for this owner.
  final String id;

  ///The name of this owner.
  final String name;

  ///The spotify uri for this Owner.
  final String uri;

  ///A link to the web api end point providing all details of this owner.
  final String href;

  ///List of external Urls for this owner object.
  final List<String> externalUrls;

  ///A Link to the image of the owner.
  final List<String> images;

  ///A link to end point to get the followers of this owner.
  final List<String> followers;

  ///List of user stats objects for this owner.
  final List<UserStats> userstats;

  ///Constructor for class owner with named arguments assignment.
  Owner({
    this.id,
    this.name,
    this.uri,
    this.href,
    this.externalUrls,
    this.images,
    this.followers,
    this.userstats,
  });

  ///A method that parses a mapped object from a json file and returns an owner object.
  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['_id'] == null ? "" : json['id'],
      name: json['name'] == null ? "" : json['name'],
      uri: json['uri'] == null ? "" : json['uri'],
      href: json['href'] == null ? "" : json['href'],
      externalUrls: json['externalUrls'] == null
          ? ""
          : parseString(json['externalUrls']),
      images: json['images'] == null ? "" : parseString(json['images']),
      // followers:
      //     json['followers'] == null ? [] : parseString(json['followers']),
      // userstats:
      //     json['userStats'] == null ? [] : parceUserStats(json['userStats']),
    );
  }
}
