import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/album.dart';

class AlbumWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final album = Provider.of<Album>(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(left: 5),
        width: 140,
        child: Column(
          children: <Widget>[
            Container(
              height: 140,
              width: 140,
              child: Image.network(
                album.images[0],
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              height: 50,
              child: Text(
                album.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(117, 117, 117, 1),
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
