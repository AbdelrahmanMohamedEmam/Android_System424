///Importing this package to use flutter libraries.
import'package:flutter/material.dart';
import 'package:spotify/Widgets/trackPlayer.dart';

///Importing the http exception model to throw an http exception.
import '../../Models/http_exception.dart';

///Importing the user provider to access the user data.
import 'package:provider/provider.dart';
import '../../Providers/artist_provider.dart';
import '../../Providers/user_provider.dart';
import '../../Models/artist.dart';

///Importing this file to use the circular widget for artist
import '../../Widgets/fav_artist_item.dart';




class Artist1 {
  String name;
  String id;
  String imageUrl;
  Artist1(this.name, this.id, this.imageUrl);
}

class ChooseFavArtists extends StatefulWidget {
  static const routeName = '/choose_fav_artists_screen';
  @override
  _ChooseFavArtistsState createState() => _ChooseFavArtistsState();
}

class _ChooseFavArtistsState extends State<ChooseFavArtists> {

  List<bool> selected=[];
  bool artistsLoaded;
  List<Artist> artists=[];
  List<int> selectedIndices = [];

  Future<void> _initializeList() async{
    final artistProvider=Provider.of<ArtistProvider>(context, listen: false);
    await artistProvider.fetchAllArtists('').then((_){setState(() {
      artistsLoaded=true;
    });});
    artists=  artistProvider.getAllArtists;
    artists.forEach((_){
      selected.add(false);
    });
  }

  @override
  void initState()  {
    artistsLoaded=false;
    _initializeList();
    super.initState();
  }



  void _showErrorDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Connection Failed'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {

    final _user=Provider.of<UserProvider>(context, listen: false);
    try {
      int length=selectedIndices.length;
      for (int i=0; i<length; i++){
        final id=artists[selectedIndices[i]].id;
        print("this id"+id);
        await _user.follow(id);
      }
    } on HttpException catch (error) {
      var errorMessage = error.toString();
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Check you internet connection :D';
      _showErrorDialog(errorMessage);
      return;
    }
    //Navigator.of(context).popUntil(ModalRoute.withName('/'));
    Navigator.of(context).pushReplacementNamed(MainWidget.routeName);
  }



  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
      selectedIndices.forEach((_){
        print(_.toString());
      });


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose Your Favorite Artists',
          style: TextStyle(
            color: Colors.white,
            fontSize: deviceSize.width * 0.06,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: !artistsLoaded?CircularProgressIndicator():Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          selectedIndices.length < 3
              ? SizedBox(
                  height: 0.001,
                )
              : Container(
                  padding: EdgeInsets.fromLTRB(
                      deviceSize.width * 0.4,
                      deviceSize.height * 0.02,
                      deviceSize.width * 0.4,
                      deviceSize.height * 0.02),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.transparent,
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: deviceSize.width * 0.04),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(deviceSize.width * 0.05),
                      side: BorderSide(color: Colors.white),
                    ),
                    onPressed: () {
                      _submit();
                    },
                  ),
                ),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Container(
                      height:selectedIndices.length < 3
                          ? deviceSize.height * 0.8
                          : deviceSize.height * 0.7,
                      child: GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: artists.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 160,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  if(selectedIndices.contains(index)){
                                    selectedIndices.remove(index);
                                  }
                                  else {
                                    selectedIndices.add(index);
                                  }
                                  selected[index]=!selected[index];
                                });
                              },
                                child:FavArtistItem(
                              selected: selected[index],
                              id: artists[index].id,
                              artistName: artists[index].name,
                              imageUrl: "https://i.scdn.co/image/c4818b1f9d0c7a793d421b51c63d82c8c768795c",
                                  // artists[index].images[0],
                            ));
                          }))
                ],
              )),
        ],
      ),
    );
  }
}
