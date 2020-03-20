import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/playlist_provider.dart';

import '../Models/playlist.dart';

class FavouritedPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<PlaylistProvider>(context);
    final temp=playlist.getMadeForYouPlaylists;
    String image =
        "https://dailymix-images.scdn.co/v1/img/ab67616d0000b273cfa4e906cda39d8f62fe81e3/1/en/default";
    String playlistName = "Daily Mix 1";

    return InkWell(
      onTap: () {},
      child: 
           
               ListTile(
                leading: Image.network(temp[0].images[0]) ,
                title: Text(temp[0].name,style: TextStyle(color: Colors.white),),
                subtitle: Text('yayaya',style: TextStyle(color: Colors.grey),)
              ),
            
            /*Container(
              child: FadeInImage(
                image: NetworkImage(image),
                placeholder: AssetImage('assets/images/temp.jpg'),
                width: 70,
                height: 70,
                //alignment: Alignment.topRight,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              height: 50,
              child: Text(
                playlistName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
            ),*/
          
        
      
    );
  }
}
