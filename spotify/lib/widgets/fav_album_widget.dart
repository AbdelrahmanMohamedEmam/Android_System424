import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/album.dart';
import 'package:spotify/Providers/album_provider.dart';
import 'package:spotify/Screens/Albums/albums_list_screen.dart';

class FavAlbumWidget extends StatefulWidget {
  final AlbumCategory category;
  final String id;
  FavAlbumWidget(this.category, this.id);
  @override
  _FavAlbumWidgetState createState() => _FavAlbumWidgetState();
}

class _FavAlbumWidgetState extends State<FavAlbumWidget> {
  @override
  Widget build(BuildContext context) {
    final album = Provider.of<Album>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AlbumsListScreen(
              albumType: widget.category,
              albumId: widget.id,
              artistName: "",
            ),
          ),
        );
      },
      child: ListTile(
        //leading: Image.network(playlist.images[0]),
        leading: FadeInImage(
          placeholder: AssetImage('assets/images/temp.jpg'),
          image: NetworkImage(album.image),
          fit: BoxFit.fill,
        ),
        title: Text(
          album.name,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          album.artists[0].name,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
