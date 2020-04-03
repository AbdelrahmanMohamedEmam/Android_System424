import 'package:flutter/material.dart';

class AlbumsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('The list of songs in album screen is built');
    String image =
        "https://dailymix-images.scdn.co/v1/img/ab67616d0000b273cfa4e906cda39d8f62fe81e3/1/en/default";
    String albumName = "Sahran";
    String albymByName = "Amr Diab";
    String releaseYear = "2020";
    String releaseDate = "May 6,2020";
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color.fromRGBO(25, 20, 20, 7.0),
            //backgroundColor: Colors.black,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
                iconSize: 26,
              ),
              PopupMenuButton(
                itemBuilder: (_) => [
                  /*PopupMenuItem(child: Text('Like'),value:0),
                PopupMenuItem(child: Text('Share'),value:1),*/
                ],
                icon: Icon(Icons.more_horiz),
              )
            ],
            expandedHeight: 270,
            
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(20, 25, 25, 7.0)
                  /*gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(100, 150, 180, 5.0),
                      Color(0xFF191414),
                    ],
                    begin: Alignment.topLeft,
                    end: FractionalOffset(1.0, 0.1),
                  ),*/
                ),
                width: double.infinity,
                padding: EdgeInsets.all(70),
                child: Image.network(
                  image,
                  fit: BoxFit.fitHeight,
                  height: 180,
                  width: 90,
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
