import 'dart:io';

import 'package:flutter/cupertino.dart';

///Importing models to use in factory methods.
import '../Models/external_url.dart';
import '../Models/user_stats.dart';
import '../Models/artistInfo.dart';

///Importing utilities file to parse objects.
import '../utilities.dart';

///A model for grouping the user data.
class User with ChangeNotifier {
  ///The name of the user.
  String name;

  ///The email of the user.
  final String email;

  ///The password of the user.
  String password;

  ///The id of the user.
  final String id;

  ///The role of the user.
  String role;

  ///The gender of the user.
  final String gender;

  ///The date of birth of the user.
  final String dateOfBirth;

  ///The spotify uri for this user.
  final String uri;

  ///A link to the web api end point providing all details of this user.
  final String href;

  ///An objects containing  the url and its type of the object.
  final ExternalUrl externalUrl;

  ///List of string urls for the images of the playlist.
  final List<String> images;

  ///List of user followers.
  final List<String> followers;

  ///List of user followings.
  final List<String> following;

  ///Product of the .
  String product;

  ///List of user stats.
  final List<UserStats> userStats;

  ///String containing the token of reset password.
  final String resetPasswordToken;

  ///String indicating the expiry date of resetting the password.
  final String resetPasswordExpires;

  ///the artist info of the user.
  final ArtistInfo artistInfo;

  ///String containing the token when user requests premium.
  final String becomePremiumToken;

  ///String indicating the expiry date of becoming premium.
  final String becomePremiumExpires;

  ///String containing the token of user artist.
  final String becomeArtistToken;

  ///String indicating the expiry date of becoming artist.
  final String becomeArtistExpires;

  ///Picked image of the user.
  File pickedImage;

  ///String containing the firebase token of the user.
  String firebaseToken;

  ///A constructor with named parameters.
  User({
    this.id,
    this.name,
    this.externalUrl,
    this.dateOfBirth,
    this.email,
    this.followers,
    this.following,
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
    this.becomeArtistExpires,
  });

  ///A factory method to decode the Json user into a user object.
  ///Check if the object is received first in the request to avoid errors.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      dateOfBirth: json['dateOfBirth'] == null ? null : json['dateOfBirth'],
      gender: json['gender'] == null ? null : json['gender'],
      uri: json['uri'] == null ? null : json['uri'],
      following: parseString(json['following']),
      followers: parseString(json['followers']),
      userStats: json['userStats'] == null
          ? []
          : parceUserStats(
              json['userStats']), //UserStats.fromjson(json['userStats']),
      //product: json['product'],
      name: json['name'],
      //externalUrl: ExternalUrl.fromJson(json['externalUrls']),
      href: json['href'] == null ? null : json['href'],
      images: parseString(json[
          'images']), //parceImage(json['images']),//json['images']==null?null:json['images'],
      role: json['role'],
      //artistInfo: ArtistInfo.fromJson(json['artistInfo']),
    );
  }

  ///A factory method to decode the Json user into a follower object.
  ///Check if the object is received first in the request to avoid errors.
  factory User.fromJson2(Map<String, dynamic> json) {
    return User(
      id: json['_id'] == null ? "" : json['_id'],
      following:
          json['following'] == null ? [] : parseString(json['following']),
      followers:
          json['followers'] == null ? [] : parseString(json['followers']),
      name: json['name'],
      images: json['images'] == null ? [] : parseString(json['images']),
      role: json['role'],
      //artistInfo: ArtistInfo.fromJson(json['artistInfo']),
    );
  }
}
