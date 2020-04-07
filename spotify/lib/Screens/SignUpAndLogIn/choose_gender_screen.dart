///Importing this package to use flutter libraries.
import 'package:flutter/material.dart';

///Importing this package to insert a dropdown menu for gender selection.
import 'package:flutter_form_builder/flutter_form_builder.dart';

///Importing the screens to navigate to it.
import 'choose_name_screen.dart';

class ChooseGenderScreen extends StatelessWidget {
  static const routeName = '/choose_gender_screen';
  @override
  Widget build(BuildContext context) {

    ///Creating a map to receive the data of the user in.
    final Map userData = ModalRoute.of(context).settings.arguments as Map;

    ///Getting the device size.
    final deviceSize = MediaQuery.of(context).size;

    ///A String holding the selected gender (Male as default).
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
          ///'What is your gender' Text.
          Container(
            margin: EdgeInsets.fromLTRB(deviceSize.width*0.06, 5, 0, deviceSize.width*0.03),
            child: Text(
              'What\'s your gender?',
              style: TextStyle(color: Colors.white, fontSize: deviceSize.width*0.06),
            ),
          ),

          ///The drop down menu showing both genders as choices.
          Container(
            margin: EdgeInsets.only(left: deviceSize.width*0.06),
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

          ///Next button.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: deviceSize.width*0.06),
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
                    ///Pushing the choose a username screen and passing the data to it.
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
