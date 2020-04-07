///Importing models to use in factory methods.
import '../Models/external_url.dart';
import '../Models/image.dart';
import '../Models/follower.dart';
import '../Models/user_stats.dart';
import '../Models/artistInfo.dart';

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
  final String images;
  //final List<Image> images;
  //final List<Follower> followers;
  //final List<Follower> following;
  String product;
  final List<UserStats> userStats;
  final String resetPasswordToken;
  final String resetPasswordExpires;
  final ArtistInfo artistInfo;
  final String becomePremiumToken;
  final String becomePremiumExpires;
  final String becomeArtistToken;
  final String becomeArtistExpires;

  ///A constructor with named parameters.
  User(
      {this.id,
      this.name,
      this.externalUrl,
      this.dateOfBirth,
      this.email,
      //this.followers,
      //this.following,
      this.gender,
      this.href,
      this.images,
      this.password,
      this.product,
      this.uri,
      this.userStats,
      this.resetPasswordToken,
      this.role,
      this.resetPasswordExpires,
      this.artistInfo,
      this.becomePremiumToken,
      this.becomePremiumExpires,
      this.becomeArtistToken,
      this.becomeArtistExpires});

  ///A factory method to decode the Json user into a user object.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      dateOfBirth: json['dateOfBirth']==null?null: json['dateOfBirth'],
      gender: json['gender']==null?null:json['gender'],
      uri: json['uri']==null?null:json['uri'],
      //following: parceFollower(json['following']),
      //followers: parceFollower(json['followers']),
      userStats: json['userStats'] == null
          ? []
          : parceUserStats(
              json['userStats']), //UserStats.fromjson(json['userStats']),
      //product: json['product'],
      name: json['name'],
      //externalUrl: ExternalUrl.fromJson(json['externalUrls']),
      href: json['href']==null?null:json['href'],
      images: json['images']==null?null:json['images'],//parceImage(json['images']),
      role: json['role'],
      //artistInfo: ArtistInfo.fromJson(json['artistInfo']),
    );
  }
}
