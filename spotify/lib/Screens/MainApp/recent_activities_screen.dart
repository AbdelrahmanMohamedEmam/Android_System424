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
  bool _isLoading = true;
  bool _isInit = false;
  @override
  void didChangeDependencies() {
    if (!_isInit) {
      user = Provider.of<UserProvider>(context, listen: false);
      notificationProvider =
          Provider.of<NotificationProvider>(context, listen: false);
      notificationProvider.fetchRecentActivities(user.token).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      _isInit=true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
     final deviceSize = MediaQuery.of(context).size;
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
            body: notificationProvider.getNotifications.length == 0
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
                    height: deviceSize.height*0.747,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scroll) {
                              if (!_isLoading &&
                                  scroll.metrics.pixels ==
                                      scroll.metrics.maxScrollExtent &&
                                  notificationProvider.nextTotifications !=
                                      null) {
                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  notificationProvider
                                      .fetchMoreRecentActivities(user.token)
                                      .then((_) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  });
                                } catch (error) {
                                  print(error.toString());
                                }
                              }
                            },
                            child: Container(
                              child: ListView.builder(
                                itemCount: notificationProvider.getNotifications.length,
                                itemBuilder: (context, i) =>
                                    ChangeNotifierProvider.value(
                                  value: notificationProvider.getNotifications[i],
                                  child: NotificationWidget(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: _isLoading ? 50.0 : 0,
                          color: Colors.transparent,
                          child: Center(
                            child: new CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
  }
}
