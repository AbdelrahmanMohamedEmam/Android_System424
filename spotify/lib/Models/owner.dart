import './user_stats.dart';
import './external_url.dart';
import './image.dart';
import './follower.dart';
import '../utilities.dart';

class Owner {
  final String id;
  final String name;
  final String uri;
  final String href;
  final List<ExternalUrl> externalUrls;
  final String images;
  final List<String> followers;
  final List<UserStats> userstats;
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
  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['_id'] == null ? "" : json['id'],
      name: json['name'] == null ? "" : json['name'],
      uri: json['uri'] == null ? "" : json['uri'],
      href: json['href'] == null ? "" : json['href'],
      externalUrls: json['externalUrls'] == null
          ? ""
          : parceExternalUrl(json['externalUrls']),
      images: json['images'] == null ? "" : json['images'],
      // followers:
      //     json['followers'] == null ? [] : parseString(json['followers']),
      // userstats:
      //     json['userStats'] == null ? [] : parceUserStats(json['userStats']),
    );
  }
}
