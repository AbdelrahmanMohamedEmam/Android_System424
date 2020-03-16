import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widgets/premium_card.dart';

class PremiumScreen extends StatelessWidget {

  static const routeName = '/premium_screen';
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    print('The premium screen is build');
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.2, 0.3, 0.5, 0.6],
                colors: [
                  Color.fromRGBO(0, 201, 156, 1),
                  Color.fromRGBO(0, 179, 143, 1),
                  Color.fromRGBO(18, 161, 132, 1),
                  Color.fromRGBO(14, 129, 106, 1),
                  Color.fromRGBO(24, 26, 19, 1),
                ],
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left: deviceSize.width * 0.15,
                      right: deviceSize.width * 0.15,
                      top: deviceSize.height * 0.1),
                  child: Text(
                    '1 month of Premium for free',
                    style: TextStyle(
                        fontSize: deviceSize.width * 0.07, color: Colors.white),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: deviceSize.width,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                        deviceSize.width * 0.1,
                        deviceSize.height * 0.05,
                        deviceSize.width * 0.1,
                        deviceSize.height * 0.05),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        PremiumCard(
                          freeText: 'Ad breaks',
                          premiumText: 'Ad-free music',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        PremiumCard(
                          freeText: 'Play in shuffle',
                          premiumText: 'Play any song',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        PremiumCard(
                          freeText: '6 skips per hour',
                          premiumText: 'Unlimited skips',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        PremiumCard(
                          freeText: 'Streaming nly',
                          premiumText: 'Offline listening',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        PremiumCard(
                          freeText: 'Basic audio quality',
                          premiumText: 'Extreme audio quality',
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(
                        deviceSize.width * 0.1, 0, deviceSize.width * 0.1, 0),
                    child: Text(
                      'You can\'t upgrade to Premium in the app. We know, it\'s not ideal.',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: deviceSize.width * 0.03),
                    )),
                Container(
                  margin: EdgeInsets.only(top: deviceSize.height * 0.09, bottom: deviceSize.height*0.08),
                  height: deviceSize.height * 0.1,
                  width: deviceSize.width * 0.8,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    color: Color.fromRGBO(49, 51, 53, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Spotify Free',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: deviceSize.width * 0.04),
                        ),
                        Text(
                          'CURRENT PLAN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: deviceSize.width * 0.025),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.black87,indent: deviceSize.width*0.3,endIndent: deviceSize.width*0.3,thickness: 0.7,),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
                  margin: EdgeInsets.only(
                      left: deviceSize.width * 0.1,
                      right: deviceSize.width * 0.1,
                      top: deviceSize.height * 0.02),
                  width: deviceSize.width * 0.9,
                  child: TextFormField(
                    controller: codeController,
                    decoration: InputDecoration(

                      border:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),),
                      labelText: 'Payment Code',
                      filled: true,
                      fillColor: Color.fromRGBO(49, 51, 53, 1),
                      labelStyle: TextStyle(color: Colors.white38),
                    ),
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color.fromRGBO(18, 161, 132, 1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: deviceSize.height*0.05, bottom: deviceSize.height*0.05 ),
                  width: deviceSize.width * 0.4,
                  height: deviceSize.height * 0.065,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color:  Color.fromRGBO(18, 161, 132, 1),
                    child: Text(
                      'Subscribe',
                      style: TextStyle(fontSize: 16),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    onPressed: () {

                    },
                  ),
                ),
                Divider(color: Colors.black87,indent: deviceSize.width*0.3,endIndent: deviceSize.width*0.3,thickness: 0.8,),
                Container(
                  margin: EdgeInsets.only(top: deviceSize.height * 0.05),
                  height: deviceSize.height * 0.4,
                  width: deviceSize.width * 0.8,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    margin: EdgeInsets.only(bottom: deviceSize.height * 0.15),
                    elevation: 5,
                    color: Color.fromRGBO(18, 161, 132, 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Premium Individual',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: deviceSize.width * 0.05),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 10,
                            left: 10,
                          ),
                          child: Text(
                            '1 month of premium for free • Ad-free music • Download to listen offline • Unlimited Skips • On-demand playback • Cancel anytime',
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: deviceSize.width * 0.025),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
