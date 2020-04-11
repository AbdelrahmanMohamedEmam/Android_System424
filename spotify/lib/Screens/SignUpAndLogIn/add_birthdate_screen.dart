///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';

///Importing this package to use different date formats.
import 'package:intl/intl.dart';

///Importing the screens to navigate to it.
import './choose_gender_screen.dart';



///This screen appears to ask the user to enter his birth date when signing up.
///The first appearing year is the current year.
///When the user press NEXT the [ChooseNameScreen] is called.
class AddBirthDateScreen extends StatefulWidget {
  static const routeName = '/add_birthdate_screen';
  @override
  _AddBirthDateScreenState createState() => _AddBirthDateScreenState();
}

class _AddBirthDateScreenState extends State<AddBirthDateScreen> {
  ///Instantiating a datetime object to save the selected date.
  DateTime _userPickedDate;

  ///Text controller to keep track with the email field.
  TextEditingController birthDateController = TextEditingController();

  ///The selected date as a string.
  String dateOfBirth;

  ///Indicates if the data is validated or not.
  bool _validate;


  ///Initialization.
  @override
  void initState() {
    _validate=true;
    birthDateController.text = _userPickedDate == null
        ? 'No Day Choosen'
        : DateFormat.yMMMMEEEEd().format(_userPickedDate).toString();
    super.initState();
  }


  ///A function to show the date picker.
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year

    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      ///Setting the text field text with the chosen date if found any.
      setState(() {
        _userPickedDate = pickedDate;
        birthDateController.text = _userPickedDate == null
            ? 'No Day Choosen'
            : DateFormat.yMMMMEEEEd().format(_userPickedDate).toString();

        if(_userPickedDate!=null)
          {
            dateOfBirth=DateFormat('yyyy-MM-dd').format(_userPickedDate).toString();
          }

      });
    });
  }

  @override
  Widget build(BuildContext context) {

    ///Creating a map to save the user data at.
    final Map userData = ModalRoute.of(context).settings.arguments as Map;


    ///Getting the device size.
    final deviceSize = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///'What's your date of birth' text.
          Container(
            margin: EdgeInsets.fromLTRB(deviceSize.width*0.05, 5, 0, deviceSize.width*0.04),
            child: Text(
              'What\'s your date of birth?',
              style: TextStyle(color: Colors.white, fontSize: deviceSize.width*0.06),
            ),
          ),

          ///Text field showing the selected date.
          Container(
            margin: EdgeInsets.only(left: deviceSize.width*0.05),
            width: deviceSize.width * 0.9,
            child: TextField(
              enabled: true,
              enableInteractiveSelection: false,
              readOnly: true,
              controller: birthDateController,
              decoration: InputDecoration(
                helperText: _validate?'':'Please enter a valid birthdate',
                helperStyle: TextStyle(color:Colors.red),
                filled: true,
                fillColor: Colors.grey,
                labelStyle: TextStyle(color: Colors.white38),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  onPressed: _presentDatePicker,
                ),
              ),
              style: TextStyle(color: Colors.white),
              showCursor: false,
            ),
          ),
          ///Next button.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: deviceSize.width*0.05),
                width: deviceSize.width * 0.4,
                height: deviceSize.height * 0.065,
                child: RaisedButton(
                  textColor: Theme.of(context).accentColor,
                  color: Colors.grey,
                  child: Text(
                    'NEXT',
                    style: TextStyle(fontSize: deviceSize.width*0.04),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  onPressed: () {
                    ///Checking that a date is selected.
                    if(dateOfBirth!=null) {
                      ///Pushing the choose gender screen and pass the data to it if true.
                      Navigator.pushNamed(
                          context, ChooseGenderScreen.routeName, arguments:
                          {
                            'email':userData['email'],
                            'password':userData['password'],
                            'dateOfBirth':dateOfBirth,
                          }
                      );
                    }
                    else
                      {
                       setState(() {
                         _validate=false;
                       });
                      }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
