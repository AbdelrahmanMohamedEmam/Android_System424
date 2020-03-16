
import '../Models/external_url.dart';
import '../Models/image.dart';
import '../Models/follower.dart';
import '../Models/user_stats.dart';
import '../utilities.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String gender;
  final String dateOfBirth;
  final String uri;
  final String href;
  final ExternalUrl externalUrl;
  final List<Image> images;
  final String country;
  final List<Follower> followers;
  final String product;
  final UserStats userStats;
  final String type;
  final bool isPremium;
  final bool isArtist;

  User({
    this.id,
    this.isArtist,
    this.isPremium,
    this.username,
    this.externalUrl,
    this.dateOfBirth,
    this.country,
    this.email,
    this.followers,
    this.gender,
    this.href,
    this.images,
    this.password,
    this.product,
    this.type,
    this.uri,
    this.userStats
  });


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      country: json['country'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      uri: json['uri'],
      type: json['type'],
      followers: parceFollower(json['followers']),
      userStats: UserStats.fromjson(json['userStats']),
      product: json['product'],
      username: json['name'],
      externalUrl: ExternalUrl.fromjson(json['externalUrls']),
      href: json['href'],
      images: parceImage(json['images']),

    );
  }
}
