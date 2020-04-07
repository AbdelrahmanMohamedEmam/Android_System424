//Importing libraries from external packages.
import 'package:flutter/foundation.dart';

///ExternalUrl Class
class ExternalUrl {
  /// The external public url to the object{required}.
  final String url;

  ///Constructor for class ExternalUrl with named arguments assignment.
  ///Required parameters:{url}.
  ExternalUrl({
    @required this.url,
  });

  ///A method that parses a mapped object from a json file and returns an externalUrl object.
  factory ExternalUrl.fromJson(Map<String, dynamic> json) {
    return ExternalUrl(
      url: json['url'] == null ? null : json['url'],
    );
  }
}
