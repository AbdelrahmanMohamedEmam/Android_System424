import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: 200,
            child: Image.network(
              'https://images.genius.com/f098769be0a95e8b182db9a9a67fb5ad.1000x1000x1.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: 180,
            child: Text(
              'Kol Hayaty',
              style: TextStyle(
                color: Colors.red,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
