
///Importing models to use in factory methods.
import '../Models/external_url.dart';
import '../Models/image.dart';
import '../Models/follower.dart';
import '../Models/user_stats.dart';

///Importing utilities file to parse objects.
import '../utilities.dart';


///A model for grouping the user data.
class User {
  final String name;
  final String email;
  String password;
  final String id;
  String role;
  final String gender;
  final String dateOfBirth;
  final String uri;
  final String href;
  final ExternalUrl externalUrl;
  final List<Image> images;
  final String country;
  final String type;
  final List<Follower> followers;
  String product;
  final UserStats userStats;
  final String resetPasswordToken;

///A constructor with named parameters.
  User({
    this.id,
    this.name,
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
    this.userStats,
    this.resetPasswordToken,
    this.role,
  });

///A factory method to decode the Json user into a user object.
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
      product: 'free',//json['product'],
      name: json['name'],
      externalUrl: ExternalUrl.fromJson(json['externalUrls']),
      href: json['href'],
      images: parceImage(json['images']),
      role: json['role'],
      resetPasswordToken: json['resetPasswordToken']

    );
  }
}
