import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({super.key, required this.text});

  final text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      content: text != null ? Text(text) : null,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
