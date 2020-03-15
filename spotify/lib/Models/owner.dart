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
  final ExternalUrl externalUrls;
  final List<Image> images;
  final String type;
  final List<Follower> followers;
  final UserStats userstats;
  Owner({
    this.id,
    this.name,
    this.uri,
    this.href,
    this.externalUrls,
    this.images,
    this.type,
    this.followers,
    this.userstats,
  });
  factory Owner.fromjason(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      name: json['name'],
      uri: json['uri'],
      href: json['href'],
      externalUrls: ExternalUrl.fromjson(json['externalUrls']),
      images: parceImage(json['images']),
      type: json['type'],
      followers: parceFollower(json['followers']),
      userstats: UserStats.fromjson(json['userStats']),
    );
  }
}
