//import packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/album.dart';
import 'package:spotify/Providers/album_provider.dart';
import 'package:spotify/Providers/user_provider.dart';
import 'package:spotify/widgets/fav_album_widget.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  UserProvider user;
  bool _isLoading = true;
  bool _isNotfound = false;

  @override
  void didChangeDependencies() async {
    user = Provider.of<UserProvider>(context, listen: false);
    try {
      await Provider.of<AlbumProvider>(context, listen: false)
          .fetchLikedAlbums(user.token)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } catch (error) {
      setState(() {
        _isNotfound = true;
        _isLoading = false;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final albumsProvider = Provider.of<AlbumProvider>(context);
    List<Album> likedAlbums;
    likedAlbums = albumsProvider.getLikedAlbums;
    return (_isLoading)
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          )
        : (_isNotfound)
            ? Scaffold(
                backgroundColor: Colors.black,
                body: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(90),
                  child: Center(
                    child: Text(
                      'Albums you like will appear here',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            : Container(
                height: 500,
                child: ListView.builder(
                  itemCount: likedAlbums.length,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                    value: likedAlbums[i],
                    child:
                        FavAlbumWidget(AlbumCategory.liked, likedAlbums[i].id),
                  ),
                ),
              );
  }
}
