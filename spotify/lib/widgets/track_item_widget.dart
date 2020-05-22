import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/track.dart';
import 'package:spotify/Providers/album_provider.dart';
import 'package:spotify/Screens/Albums/albums_list_screen.dart';

class TrackItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final track = Provider.of<Track>(context);
    AlbumProvider albumProvider =
        Provider.of<AlbumProvider>(context, listen: false);

    return ListTile(
      onTap: () {
        albumProvider.setSearchAlbum(track.album);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AlbumsListScreen(
              albumType: AlbumCategory.search,
              albumId: track.album.id,
            ),
          ),
        );
      },
      title: Text(
        track.name,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          track.album.image,
        ),
      ),
      subtitle: Text(
        "Song. " + track.album.name,
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
