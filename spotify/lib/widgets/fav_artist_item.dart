import 'package:flutter/material.dart';
import 'package:badges/badges.dart';


///It is a badge widget.
///Provide it by and id, artist name, his/her image and either it is selected or not to render an icon.
class FavArtistItem extends StatelessWidget {
  final String id;
  final String artistName;
  final String imageUrl;
  final bool selected;

  FavArtistItem({
    this.id,
    this.imageUrl,
    this.artistName,
    this.selected
  });


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Badge(
          badgeColor: Colors.transparent,
          shape: BadgeShape.circle,
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: deviceSize.height * 0.07,
          ),
          badgeContent: selected
              ? Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: deviceSize.height * 0.05,
                )
              : null,
        ),
        Container(
            padding: EdgeInsets.all(deviceSize.height * 0.01.toDouble()),
            child: Text(
              artistName,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                  color: Colors.white, fontSize: deviceSize.width * 0.04),
            ))
      ],
    );
  }
}
