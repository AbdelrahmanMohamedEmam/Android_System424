import 'package:flutter/material.dart';
import 'package:spotify/Screens/ArtistMode/my_music_screen.dart';
import '../../Screens/ArtistMode/my_music_screen.dart';
import '../../Providers/user_provider.dart';
import 'package:provider/provider.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({Key key}) : super(key: key);
  static const routeName = '/artist_screen';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    bool user =
        Provider.of<UserProvider>(context, listen: false).isUserArtist();
    if (!user) {
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.black,
         title : Text('Spotify For Artists' , style: TextStyle(color: Colors.white),),
       ),
       backgroundColor: Colors.black,
       body : Center(
         child: Container(
           margin: EdgeInsets.all(15),
           child :Column (
             children :<Widget>[
               SizedBox(height: deviceSize.height*0.25,),
               Text('Welcome to Spotify For Artists ,you cant use artist features' ,
             style: TextStyle(fontSize: 20 , color: Colors.green[700]),
               textAlign: TextAlign.center,
             ),
               SizedBox(height: deviceSize.height*0.25,),
               Text('you can try it using my account' , style: TextStyle(color: Colors.white),),
               Text('here is a free to try account!' , style: TextStyle(color: Colors.white),),
               Text('e-mail : amr@email.com' , style: TextStyle(color: Colors.white),),
               Text('password : password3' , style: TextStyle(color: Colors.white),),
             ],
           )
       ),
       ),
     );
    } else {
      return MyMusicScreen();
    }
  }
}
