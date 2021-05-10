import 'package:flutter/material.dart';

import '../../data/models/user.dart';

class GenderCheckboxes extends StatefulWidget {
  final Function(Gender) updateGender;

  const GenderCheckboxes(this.updateGender);

  @override
  _GenderCheckboxesState createState() => _GenderCheckboxesState();
}

class _GenderCheckboxesState extends State<GenderCheckboxes> {
  var _checkBoxMale = false;
  var _checkBoxFemale = false;

  Widget _buildCheckboxListTile(String title, Gender gender) {
    return CheckboxListTile(
      title: Text(title),
      value: gender == Gender.male ? _checkBoxMale : _checkBoxFemale,
      onChanged: (newValue) {
        if (newValue == null) {
          return;
        }

        setState(() {
          if (gender == Gender.male) {
            _checkBoxMale = newValue;
            _checkBoxFemale = !newValue;
            widget.updateGender(newValue == true ? Gender.male : Gender.female);
          } else {
            _checkBoxFemale = newValue;
            _checkBoxMale = !newValue;
            widget.updateGender(newValue == true ? Gender.female : Gender.male);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildCheckboxListTile('Male', Gender.male),
      _buildCheckboxListTile('Female', Gender.female)
    ]);
  }
}
