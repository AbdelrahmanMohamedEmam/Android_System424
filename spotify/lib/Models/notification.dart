import 'package:flutter/cupertino.dart';

///A model to save the notification data;
class Notifications with ChangeNotifier {
  ///String to show title of the notification.
  final String title;

  ///String to show the body of the notification.
  final String body;

  ///String to show the uri of the string.
  final String uri;

  ///String to show the id of the user or playlist concerned to this notification.
  final String id;

  ///String to save the href of the notifiation
  final String href;

  ///String to save the image of the notification.
  final String images;

  ///Constructor for class album with named arguments assignment.
  Notifications(
      {this.title, this.body, this.uri, this.id, this.href, this.images});

  ///A method that parses a mapped object from a json file and returns an notification object.
  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      title: json['notification']['title'] == null
          ? ""
          : json['notification']['title'],
      body: json['notification']['body'] == null
          ? ""
          : json['notification']['body'],
      uri: json['data']['uri'] == null ? "" : json['data']['uri'],
      href: json['data']['href'] == null ? "" : json['data']['href'],
      id: json['data']['id'] == null ? "" : json['data']['id'],
      images: json['data']['images'],
    );
  }
}
