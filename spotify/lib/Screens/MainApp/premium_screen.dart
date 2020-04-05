///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';

///Importing this widget to user the modified card widget.
import '../../Widgets/premium_card.dart';

///Importing the user provider to access the user data.
import 'package:provider/provider.dart';
import '../../Providers/user_provider.dart';

///Importing the http exception model to throw an http exception.
import '../../Models/http_exception.dart';


///This screen is responsible to display the premium feature.
///If the user isn't premium he can subscribe at this screen.
class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key key}) : super(key: key);
  static const routeName = '/premium_screen';
  @override
  _PremiumScreenState createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {

  ///Indicates the input field isn't empty.
  bool _validate;

  ///Indicates if the screen is loading.
  ///If true, a circular progress widget will appear.
  bool _isLoading;

  ///Indicates if an email is sent or not.
  bool _isEmailSent;

  ///A text controller for the code field.
  final codeController = TextEditingController();

  ///Initializations.
  @override
  void initState() {
    _isEmailSent=false;
    _validate = true;
    _isLoading = false;
    super.initState();
  }


  ///A function to show an error dialog when needed.
  void _showErrorDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Upgrading Failed. Please try again later.'),
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


  ///A function called when the 'Subscribe' button is pressed.
  ///[HttpException] class is used to create an error object to throw it in case of failure.
  Future<void> _submit() async {
    try {
      await upgradeToPremium().then((_) {return;});
    } catch (error) {
      setState(() {
        _isLoading = false;
        _showErrorDialog(error.toString());
        //return;
      });
    }
  }

  ///A function to upgrade to premium.
  ///Ask the [UserProvider] to send a request to upgrade the user.
  ///Throws an error if request failed.
  Future<void> upgradeToPremium() async {
    String confirmationCode = codeController.text;
    _isLoading = true;
    final _user = Provider.of<UserProvider>(context, listen: false);
    try {
      await _user.upgradePremium(confirmationCode).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {

    ///Getting the device size.
    final deviceSize = MediaQuery.of(context).size;
    final _user = Provider.of<UserProvider>(context, listen: false);


    if(!_isEmailSent && !_user.isUserPremium()){
      _user.askForPremium();
    }

    ///If the screen is loading show a circular progress.
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 0.2, 0.3, 0.5, 0.57],
                      colors: [
                        Colors.green[700],
                        Colors.green[600],
                        Colors.green[500],
                        Colors.green[500],
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
                              fontSize: deviceSize.width * 0.07,
                              color: Colors.white),
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
                          padding: EdgeInsets.fromLTRB(deviceSize.width * 0.1,
                              0, deviceSize.width * 0.1, 0),
                          child: Text(
                            _user.isUserPremium()
                                ? 'You are already a premium user. We hope you are enjoying Spotify.'
                                : 'You have received an email with your premium code, kindly check your email and enter the code below to get your premium features.',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: deviceSize.width * 0.03),
                          )),
                      Container(
                        margin: EdgeInsets.only(
                            top: deviceSize.height * 0.09,
                            bottom: deviceSize.height * 0.08),
                        height: deviceSize.height * 0.1,
                        width: deviceSize.width * 0.8,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          color: _user.isUserPremium()
                              ? Colors.green[800]
                              : Color.fromRGBO(49, 51, 53, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                _user.isUserPremium()
                                    ? 'Spotify Premium'
                                    : 'Spotify Free',
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
                      _user.isUserPremium()
                          ? SizedBox(
                              height: 0,
                            )
                          : Divider(
                              color: Colors.black87,
                              indent: deviceSize.width * 0.3,
                              endIndent: deviceSize.width * 0.3,
                              thickness: 0.7,
                            ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        margin: EdgeInsets.only(
                            left: deviceSize.width * 0.1,
                            right: deviceSize.width * 0.1,
                            top: deviceSize.height * 0.02),
                        width: deviceSize.width * 0.9,
                        child: _user.isUserPremium()
                            ? SizedBox(
                                height: 0,
                              )
                            : TextFormField(
                                controller: codeController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  labelText: 'Payment Code',
                                  filled: true,
                                  fillColor: Color.fromRGBO(49, 51, 53, 1),
                                  helperText: !_validate
                                      ? 'Please enter a valid code'
                                      : '',
                                  helperStyle: TextStyle(color: Colors.red),
                                  labelStyle: TextStyle(color: Colors.white38),
                                ),
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.green[
                                    800], //Color.fromRGBO(18, 161, 132, 1),
                              ),
                      ),
                      _user.isUserPremium()
                          ? SizedBox(
                              height: 0,
                            )
                          : Container(
                              margin: EdgeInsets.only(
                                  top: deviceSize.height * 0.05,
                                  bottom: deviceSize.height * 0.05),
                              width: deviceSize.width * 0.4,
                              height: deviceSize.height * 0.065,
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: Colors.green[
                                    800], //Color.fromRGBO(18, 161, 132, 1),
                                child: Text(
                                  'Subscribe',
                                  style: TextStyle(fontSize: 16),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                ),
                                onPressed: () {
                                  if (codeController.text.isEmpty) {
                                    setState(() {
                                      _validate = false;
                                    });
                                  } else {
                                    _submit();
                                  }
                                },
                              ),
                            ),
                      _user.isUserPremium()
                          ? SizedBox(
                              height: 0,
                            )
                          : Divider(
                              color: Colors.black87,
                              indent: deviceSize.width * 0.3,
                              endIndent: deviceSize.width * 0.3,
                              thickness: 0.8,
                            ),
                      Container(
                        margin: EdgeInsets.only(top: deviceSize.height * 0.05),
                        height: deviceSize.height * 0.4,
                        width: deviceSize.width * 0.8,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          margin:
                              EdgeInsets.only(bottom: deviceSize.height * 0.15),
                          elevation: 5,
                          color: Colors
                              .green[800], //Color.fromRGBO(18, 161, 132, 1),
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
