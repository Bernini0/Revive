import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revive/utils/constants.dart';

class MyDropdownButton extends StatefulWidget {
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String selectedOption = 'Weekly';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kVerticalPadding),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Colors.black,
          value: selectedOption,
          onChanged: (String? newValue) {
            setState(() {
              selectedOption = newValue!;
            });
          },
          underline: Container(),
          padding: EdgeInsets.zero,
          items: <String>['Weekly', 'Half-yearly', 'Yearly']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}