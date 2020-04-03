
import 'package:flutter/material.dart';
import '../../Models/artist.dart';
import '../../Providers/artist_provider.dart';
import 'package:provider/provider.dart';


class ManageProfileScreen extends StatefulWidget {
  static const   routeName='/manage_profile_screen';

  @override
  _ManageProfileScreenState createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  bool _isInit = true;

  /*void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<ArtistProvider>(
          context, listen: false)
          .fetchChoosedArtist(
      );
      _isInit = false;
      super.didChangeDependencies();
    }
  }*/

  String artistImage =
      "https://img.discogs.com/HSUEWRWhz_K3_6ycQh0p4LdH_D0=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-4105059-1573135200-3103.jpeg.jpg";

  void _goToOverview(BuildContext ctx ,)
  {
    Navigator.of(ctx).pushNamed('/overview_screen' ,);
  }

  void _goToStats(BuildContext ctx ,)
  {
    Navigator.of(ctx).pushNamed('/stats_screen' ,);
  }

  void _goToMymusic(BuildContext ctx ,)
  {
    Navigator.of(ctx).pushNamed('/my_music_screen' ,);
  }

  @override
  Widget build(BuildContext context) {
    //final artistProvider01 = Provider.of<ArtistProvider>(context , listen: false);
    //Artist artistInfo01;
    //artistInfo01 = artistProvider01.getChoosedArtist;
    //print(artistInfo01.name);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('artist name will be added'),
      ),
      drawer: Drawer(

        child: Container(
          color: Colors.black,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('artist name'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(artistImage),
                ),
              ),
              ListTile(
                title: Text('Overview',
                style: TextStyle(
                    color: Colors.grey,
                ),
                ),
                onTap: () => _goToOverview(context),
              ),
              ListTile(
                title: Text('Stats',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onTap: () => _goToStats(context),
              ),
              ListTile(
                title: Text('Your Music',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onTap: () => _goToMymusic(context),
              ),

            ],
          ),
        ),
      ),



    );
  }
}
