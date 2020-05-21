import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/notification.dart';
import 'package:spotify/Providers/notification_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/widgets/notification_widget.dart';

class RecentActivitiesScreen extends StatefulWidget {
  @override
  _RecentActivitiesScreenState createState() => _RecentActivitiesScreenState();
}

class _RecentActivitiesScreenState extends State<RecentActivitiesScreen> {
  UserProvider user;
  NotificationProvider notificationProvider;
  List<Notifications> notifications;
  bool _isLoading = true;
  @override
  void didChangeDependencies() {
    user = Provider.of<UserProvider>(context, listen: false);
    notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    notificationProvider.fetchRecentActivities(user.token).then((_) {
      notifications = notificationProvider.getNotifications;
      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Recent activities',
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            backgroundColor: Theme.of(context).accentColor,
            body: notifications.length == 0
                ? Center(
                    child: Text(
                      "There is no recent activity",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, i) => ChangeNotifierProvider.value(
                        value: notifications[i],
                        child: NotificationWidget(),
                      ),
                    ),
                  ),
          );
  }
}
