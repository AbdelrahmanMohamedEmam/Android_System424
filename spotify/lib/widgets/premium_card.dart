import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///It is a merged card widgets
///Provide it by the premium text and the free user text to get a comparison widget.
class PremiumCard extends StatelessWidget {
  final String premiumText;
  final String freeText;

  PremiumCard({this.premiumText, this.freeText});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: deviceSize.height * 0.2,
              width: deviceSize.width * 0.4,
              child: Card(
                color: Color.fromRGBO(49, 51, 53, 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: deviceSize.height * 0.02),
                      child: Text(
                        'Free',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: deviceSize.height * 0.03,
                          left: deviceSize.width * 0.03,
                          right: deviceSize.width * 0.03),
                      child: Text(
                        freeText,
                        style: TextStyle(
                          fontSize: deviceSize.height * 0.03,
                          color: Colors.white,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                elevation: 15,
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(0),
                        topRight: Radius.circular(0))),
              )),
          Container(
              height: deviceSize.height * 0.2,
              width: deviceSize.width * 0.4,
              child: Card(
                color: Colors.green[800], //Color.fromRGBO(18, 161, 132, 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: deviceSize.height * 0.02),
                      child: Text(
                        'Premium',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: deviceSize.height * 0.03,
                          left: deviceSize.width * 0.03,
                          right: deviceSize.width * 0.03),
                      child: Text(
                        premiumText,
                        style: TextStyle(
                          fontSize: deviceSize.height * 0.03,
                          color: Colors.white,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                elevation: 15,
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15))),
              )),
        ],
      ),
    );
  }
}
