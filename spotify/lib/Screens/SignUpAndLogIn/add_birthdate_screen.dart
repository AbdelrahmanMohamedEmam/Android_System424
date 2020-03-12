import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './choose_gender_screen.dart';

class AddBirthDateScreen extends StatefulWidget {
  static const routeName = '/add_birthdate_screen';
  @override
  _AddBirthDateScreenState createState() => _AddBirthDateScreenState();
}

class _AddBirthDateScreenState extends State<AddBirthDateScreen> {
  DateTime _userPickedDate;
  TextEditingController birthDateController = TextEditingController();
  String dateOfBirth;
  bool _validate;

  @override
  void initState() {
    _validate=true;
    birthDateController.text = _userPickedDate == null
        ? 'No Day Choosen'
        : DateFormat.yMMMMEEEEd().format(_userPickedDate).toString();
    super.initState();
  }

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
    final Map userData = ModalRoute.of(context).settings.arguments as Map;
    print(userData['email'].toString());
    print(userData['password'].toString());

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
          Container(
            margin: EdgeInsets.fromLTRB(25, 5, 0, 10),
            child: Text(
              'What\'s your date of birth?',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
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
                    color: Colors.white38,
                  ),
                  onPressed: _presentDatePicker,
                ),
              ),
              style: TextStyle(color: Colors.white),
              showCursor: false,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 25),
                width: deviceSize.width * 0.4,
                height: deviceSize.height * 0.065,
                child: RaisedButton(
                  textColor: Theme.of(context).accentColor,
                  color: Colors.grey,
                  child: Text(
                    'NEXT',
                    style: TextStyle(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  onPressed: () {

                    if(dateOfBirth!=null) {
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
