import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'choose_name_screen.dart';

class ChooseGenderScreen extends StatelessWidget {
  static const routeName = '/choose_gender_screen';
  @override
  Widget build(BuildContext context) {
    final Map userData = ModalRoute.of(context).settings.arguments as Map;
    final deviceSize = MediaQuery.of(context).size;
    String gender='Male';
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
              'What\'s your gender?',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            width: deviceSize.width * 0.9,
            child: FormBuilderDropdown(
              onChanged: (value){
                gender=value;
              },
              style: TextStyle(color: Colors.black54),
              attribute: "gender",
              decoration: InputDecoration(
                labelText: "Gender",
                filled: true,
                fillColor: Colors.grey,
              ),
              initialValue: 'Male',
              hint: Text('Select Gender'),
              validators: [FormBuilderValidators.required()],
              items: ['Male', 'Female']
                  .map((gender) =>
                      DropdownMenuItem(value: gender, child: Text("$gender")))
                  .toList(),
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
                    print(gender);
                    Navigator.pushNamed(context, ChooseNameScreen.routeName, arguments: {
                      'email':userData['email'],
                      'password':userData['password'],
                      'dateOfBirth':userData['dateOfBirth'],
                      'gender':gender
                    });
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
