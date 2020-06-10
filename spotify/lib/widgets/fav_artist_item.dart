import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

///It is a badge widget.
///Provide it by and id, artist name, his/her image and either it is selected or not to render an icon.
class FavArtistItem extends StatelessWidget {
  final String id;
  final String artistName;
  final String imageUrl;
  final bool selected;

  FavArtistItem({this.id, this.imageUrl, this.artistName, this.selected});

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
            radius: deviceSize.height * 0.06,
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
            height: deviceSize.height * 0.07613,
            padding: EdgeInsets.only(
                top: deviceSize.height * 0.008.toDouble(),
                bottom: deviceSize.height * 0.008.toDouble(),
                left: deviceSize.width * 0.03.toDouble(),
                right: deviceSize.width * 0.012.toDouble()),
            child: Text(
              artistName,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                  color: Colors.white, fontSize: deviceSize.width * 0.04),
              maxLines: 2,
              textAlign: TextAlign.center,
            ))
      ],
    );
  }
}
