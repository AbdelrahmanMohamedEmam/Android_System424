//Importing material
import 'package:flutter/material.dart';
import 'package:spotify/API_Providers/notificationAPI.dart';
//Importing Models
import '../Models/notification.dart';

class NotificationProvider with ChangeNotifier {
  final String baseUrl;
  NotificationProvider({this.baseUrl});
  List<Notifications> _notifications = [];

  List<Notifications> get getNotifications {
    return [..._notifications];
  }

  String nextTotifications;

  ///A method that fetches the recent notifications and set them in the Notifications  List.
  ///It takes a [String] token for verification.
  Future<void> fetchRecentActivities(String token) async {
    NotificationsAPI notificationsAPI = NotificationsAPI(baseUrl: baseUrl);
    try {
      final extractedList = await notificationsAPI.fetchNotificationsAPI(token);
      nextTotifications = notificationsAPI.getNextNotificationUrl;
      final List<Notifications> loadedNotifications = [];
      for (int i = 0; i < extractedList.length; i++) {
        loadedNotifications.add(Notifications.fromJson(extractedList[i]));
      }
      _notifications = loadedNotifications;
      notifyListeners();
    } catch (error) {}
  }
}
