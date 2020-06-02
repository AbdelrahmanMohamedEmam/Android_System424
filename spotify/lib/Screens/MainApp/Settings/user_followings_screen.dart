import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/user.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/widgets/following_item_widget.dart';

class UserFollowingScreen extends StatefulWidget {
  @override
  _UserFollowingScreenState createState() => _UserFollowingScreenState();
}

class _UserFollowingScreenState extends State<UserFollowingScreen> {
  UserProvider user;
  List<User> followingList;
  bool _isLoading = true;

  @override
  void didChangeDependencies() async {
    user = Provider.of<UserProvider>(context, listen: false);
    await user.fetchFollowing(user.token).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    followingList = user.getfollowingUsers;
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
            backgroundColor: Color.fromRGBO(18, 18, 18, 2),
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(48, 44, 44, 1),
              centerTitle: true,
              title: Text(
                'Following',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            body: ListView.builder(
              itemCount: followingList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: followingList[i],
                child: FollowingItemWidget(),
              ),
            ),
          );
  }
}
