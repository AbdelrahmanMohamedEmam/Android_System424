import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:spotify/Models/http_exception.dart';

class NotificationsEndPoints {
  static const me = '/me';
  static const notifications = '/notifications';
}

class NotificationsAPI {
  final String baseUrl;
  NotificationsAPI({
    this.baseUrl,
  });
  String nextNotifications;
  String get getNextNotificationUrl{
    return nextNotifications;
  }

  Future<List> fetchNotificationsAPI(String token) async {
    final url = baseUrl +
        NotificationsEndPoints.me +
        NotificationsEndPoints.notifications;
    try {
      final response = await http.get(
        url,
        headers: {"authorization": "Bearer " + token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> temp = json.decode(response.body);
        nextNotifications = temp['data']['results']["next"];
        final extractedList = temp['data']['results']['items'] as List;
        return extractedList;
      } else {
        print(response.statusCode);
        throw HttpException(json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
