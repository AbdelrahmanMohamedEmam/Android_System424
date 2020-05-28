// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:spotify/Models/user.dart';

// class FollowersItemWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<User>(context, listen: false);
//     return ListTile(
//       title: Text(
//         user.name,
//       ),
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(
//           user.images[0],
//         ),
//       ),
//       subtitle: Text(
//         user.followers.length.toString() + " followers",
//       ),
//       trailing: Icon(
//         Icons.check,
//         color: Colors.green,
//       ),
//     );
//   }
// }
