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

  /*
   List<Artist1> artists=[
    Artist1('Amr diab', '1','https://i1.sndcdn.com/artworks-000658549528-9mu6tf-t500x500.jpg' ),
    Artist1('Mohamed Hamaki','2','https://i1.sndcdn.com/avatars-000607873275-iw3z9m-t500x500.jpg'),
    Artist1('Nancy Ajram','3','https://i1.sndcdn.com/artworks-000091444083-dn5ew5-t500x500.jpg'),
    Artist1('Sherine AbdelWahab','4','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ6ET8CFFcJkcfcZDmgcxxWGVvCp1Kmy3VnaAxtcngViQrDhJF3'),
    Artist1('Fairouz','5','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSGJMPuR-1noMtv9f87F2dsMRbtLMZYHBZUUPCGaoyEkrs6YSST'),
    Artist1('Coldplay','6','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTZbhv4o5A2mARqRK_9WyPaLaHer4WoW5rllVOe0DDPub-AW0gr'),
    Artist1('Maroon 5','7','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSsvikKGyM3IS_Q20frloufT1iQA5m8hb24E4wAR797epgMzK42'),
    Artist1('Ed Sheeran','8','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSkak3MjPzEfxLWouP_k49NePh4efSobdn4Cky0wxzSAHGSrz8R'),
    Artist1('Amr diab', '9','https://i1.sndcdn.com/artworks-000658549528-9mu6tf-t500x500.jpg' ),
    Artist1('Mohamed Hamaki','10','https://i1.sndcdn.com/avatars-000607873275-iw3z9m-t500x500.jpg'),
    Artist1('Nancy Ajram','11','https://i1.sndcdn.com/artworks-000091444083-dn5ew5-t500x500.jpg'),
    Artist1('Sherine AbdelWahab','12','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ6ET8CFFcJkcfcZDmgcxxWGVvCp1Kmy3VnaAxtcngViQrDhJF3'),
    Artist1('Fairouz','13','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSGJMPuR-1noMtv9f87F2dsMRbtLMZYHBZUUPCGaoyEkrs6YSST'),
    Artist1('Coldplay','14','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTZbhv4o5A2mARqRK_9WyPaLaHer4WoW5rllVOe0DDPub-AW0gr'),
    Artist1('Maroon 5','15','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSsvikKGyM3IS_Q20frloufT1iQA5m8hb24E4wAR797epgMzK42'),
    Artist1('Ed Sheeran','16','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSkak3MjPzEfxLWouP_k49NePh4efSobdn4Cky0wxzSAHGSrz8R'),
  ];*/









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
    await artistProvider.fetchAllArtists().then((_){setState(() {
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

    //final _artistProvider=Provider.of<ArtistProvider>(context, listen: false);
    try {
      //Call the request to add the fav artists
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
                              imageUrl:artists[index].images[0].url,
                            ));
                          }))
                ],
              )),
        ],
      ),
    );
  }
}
