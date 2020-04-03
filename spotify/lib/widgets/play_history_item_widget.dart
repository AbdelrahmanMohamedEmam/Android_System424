import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Models/artist.dart';
import 'package:spotify/Models/track.dart';
import 'package:spotify/Providers/playable_track.dart';

//import '../Models/play_history.dart';
//import '../Screens/Playlists/playlists_list_screen.dart';

class PlayHistoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final playhistory = Provider.of<PlayHistory>(context);
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Provider.of<PlayableTrackProvider>(context, listen: false)
            .setCurrentSong(
          Track(
              id: '2',
              name: 'Gamda Bas',
              album: 'Sahran',
              artists: [
                Artist(
                  name: 'Amr Diab',
                  //bio: '',
                )
              ],
              imgUrl:
                  'https://i1.sndcdn.com/artworks-000685259938-at3rot-t500x500.jpg',
              href:
                  'https://nogomistars.com/Online_Foldern/Amr_Diab/Sahraan/Nogomi.com_Amr_Diab-01.Gamda_Bas.mp3',
              trackNumber: 1),
        );
      },
      child: Container(
        height: deviceSize.height * 0.317,
        width: deviceSize.width * 0.341,
        child: Column(
          children: <Widget>[
            Container(
              height: deviceSize.height * 0.205,
              width: deviceSize.width * 0.341,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular((deviceSize.width * 0.341) / 2),
                child: FadeInImage(
                  image: NetworkImage(
                      'https://i1.sndcdn.com/artworks-000685259938-at3rot-t500x500.jpg'),
                  placeholder: AssetImage('assets/images/temp.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: deviceSize.height * 0.0147,
              ),
              height: deviceSize.height * 0.0219,
              width: double.infinity,
              child: Text(
                'Sahran',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: deviceSize.width * 0.0292,
                  color: Colors.white,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
