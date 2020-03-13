import 'package:flutter/material.dart';
import '../../widgets/item_widget.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';
  @override
  Widget build(BuildContext context) {
    print('The home screen is build');
    return Scaffold(
        backgroundColor: Color.fromRGBO(18, 18, 18, 2),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(18, 18, 18, 1),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CategoryList(),
              CategoryList(),
              CategoryList(),
            ],
          ),
        ));
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              'Recently played',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => ItemWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
