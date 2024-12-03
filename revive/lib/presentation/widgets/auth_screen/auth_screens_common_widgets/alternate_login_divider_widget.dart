import 'package:flutter/material.dart';

class AlternateLoginDividerWidget extends StatelessWidget {
  const AlternateLoginDividerWidget({super.key, required this.text});

  final text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: ShapeDecoration(
              color: Color(0xFFC6CACC),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.50, color: Color(0xFF919699)),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Or ${text} with',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: ShapeDecoration(
              color: Color(0xFFC6CACC),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.50, color: Color(0xFF919699)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
