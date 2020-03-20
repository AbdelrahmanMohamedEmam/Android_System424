import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Models/http_exception.dart';
import '../../Providers/artist_provider.dart';
import 'package:provider/provider.dart';
import '../../Widgets/fav_artist_item.dart';
import '../../Screens/MainApp/tabs_screen.dart';
import '../../Models/artist.dart';
import '../../Providers/artist_provider.dart';


class Artist {
  String name;
  String id;
  String imageUrl;
  Artist(this.name, this.id, this.imageUrl);
}

class ChooseFavArtists extends StatefulWidget {
  static const routeName = '/choose_fav_artists_screen';
  final List<int> selectedIndices = [];
   List<Artist> artists=[
    Artist('Amr diab', '1','https://i1.sndcdn.com/artworks-000658549528-9mu6tf-t500x500.jpg' ),
    Artist('Mohamed Hamaki','2','https://i1.sndcdn.com/avatars-000607873275-iw3z9m-t500x500.jpg'),
    Artist('Nancy Ajram','3','https://i1.sndcdn.com/artworks-000091444083-dn5ew5-t500x500.jpg'),
    Artist('Sherine AbdelWahab','4','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ6ET8CFFcJkcfcZDmgcxxWGVvCp1Kmy3VnaAxtcngViQrDhJF3'),
    Artist('Fairouz','5','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSGJMPuR-1noMtv9f87F2dsMRbtLMZYHBZUUPCGaoyEkrs6YSST'),
    Artist('Coldplay','6','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTZbhv4o5A2mARqRK_9WyPaLaHer4WoW5rllVOe0DDPub-AW0gr'),
    Artist('Maroon 5','7','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSsvikKGyM3IS_Q20frloufT1iQA5m8hb24E4wAR797epgMzK42'),
    Artist('Ed Sheeran','8','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSkak3MjPzEfxLWouP_k49NePh4efSobdn4Cky0wxzSAHGSrz8R'),
    Artist('Amr diab', '9','https://i1.sndcdn.com/artworks-000658549528-9mu6tf-t500x500.jpg' ),
    Artist('Mohamed Hamaki','10','https://i1.sndcdn.com/avatars-000607873275-iw3z9m-t500x500.jpg'),
    Artist('Nancy Ajram','11','https://i1.sndcdn.com/artworks-000091444083-dn5ew5-t500x500.jpg'),
    Artist('Sherine AbdelWahab','12','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ6ET8CFFcJkcfcZDmgcxxWGVvCp1Kmy3VnaAxtcngViQrDhJF3'),
    Artist('Fairouz','13','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSGJMPuR-1noMtv9f87F2dsMRbtLMZYHBZUUPCGaoyEkrs6YSST'),
    Artist('Coldplay','14','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTZbhv4o5A2mARqRK_9WyPaLaHer4WoW5rllVOe0DDPub-AW0gr'),
    Artist('Maroon 5','15','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSsvikKGyM3IS_Q20frloufT1iQA5m8hb24E4wAR797epgMzK42'),
    Artist('Ed Sheeran','16','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSkak3MjPzEfxLWouP_k49NePh4efSobdn4Cky0wxzSAHGSrz8R'),
  ];
  //List<Artist> artists=[];






  @override
  _ChooseFavArtistsState createState() => _ChooseFavArtistsState();
}

class _ChooseFavArtistsState extends State<ChooseFavArtists> {



  List<bool> selected=[];


  Future<void> _initializeList() async{
  await Provider.of<ArtistProvider>(context, listen: false).fetchMultipleArtists();
  //widget.artists= Provider.of<ArtistProvider>(context, listen: false).getMultipleArtists;
  }

  @override
  void initState()  {
   // _initializeList();
    widget.artists.forEach((_){
      selected.add(false);
    });
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
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
    Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
  }



  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

      widget.selectedIndices.forEach((_){
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          widget.selectedIndices.length < 3
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
                      height:widget.selectedIndices.length < 3
                          ? deviceSize.height * 0.8
                          : deviceSize.height * 0.7,
                      child: GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: widget.artists.length,
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
                                  if(widget.selectedIndices.contains(index)){
                                    widget.selectedIndices.remove(index);
                                  }
                                  else {
                                    widget.selectedIndices.add(index);
                                  }
                                  selected[index]=!selected[index];
                                });
                              },
                                child:FavArtistItem(
                              selected: selected[index],
                              id: widget.artists[index].id,
                              artistName: widget.artists[index].name,
                              imageUrl: widget.artists[index].imageUrl,
                            ));
                          }))
                ],
              )),
        ],
      ),
    );
  }
}
