import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/playlist.dart';
import 'package:spotify/Providers/playlist_provider.dart';

import 'playlist_item_widget.dart';

class MadeForYouPlaylists extends StatelessWidget {
  // final PlaylistCategory playlistType;
  // final String playlistID;
  //MadeForYouPlaylists(this.playlistType, this.playlistID);
  List<Playlist> madeForYou;
  @override
  Widget build(BuildContext context) {
    madeForYou =
        Provider.of<PlaylistProvider>(context, listen: false).getMadeForYou;
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            height: ((deviceSize.height) * 0.4) * 0.14,
            width: double.infinity,
            margin: EdgeInsets.only(
              bottom: ((deviceSize.height) * 0.4) * 0.0357,
              left: deviceSize.width * 0.0244,
              top: ((deviceSize.height) * 0.4) * 0.0535,
            ),
            child: Text(
              "You might also like",
              style: TextStyle(
                color: Color.fromRGBO(196, 189, 187, 20),
                fontSize: deviceSize.width * 0.0609,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: (deviceSize.height) * 0.2929,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: madeForYou.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, i) {
                return InkWell(
                  child: PlaylistWidget(
                    playlistType: PlaylistCategory.madeForYou,
                  ),
                );
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: deviceSize.width * 0.0244,
                  ),

                );
              },
            ),
          )
        ],
      ),
    );
  }
}
