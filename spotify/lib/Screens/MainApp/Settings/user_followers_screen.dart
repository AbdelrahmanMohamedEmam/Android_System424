// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:spotify/Providers/user_provider.dart';
// import 'package:spotify/widgets/followers_item_widget.dart';

// class UserFollowersScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context, listen: false);
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(18, 18, 18, 2),
//       appBar: AppBar(
//         backgroundColor: Color.fromRGBO(48, 44, 44, 1),
//         centerTitle: true,
//         title: Text(
//           'Followers',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 15,
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemBuilder: (context, i) => ChangeNotifierProvider.value(
//           value: user.getfollowers[i],
//           child: FollowersItemWidget(),
//         ),
//       ),
//     );
//   }
// }

// // Widget listTileUserWidget(UserProvider user) {
// //   return ListTile(
// //     title: Text(
// //       user.username,
// //     ),
// //     leading: CircleAvatar(
// //       backgroundImage: NetworkImage(
// //         user.userImage[0],
// //       ),
// //     ),
// //     subtitle: Text(
// //       user.getfollowers.length.toString() + " followers",
// //     ),
// //     trailing: Icon(
// //       Icons.check,
// //       color: Colors.green,
// //     ),
// //   );
// // }
