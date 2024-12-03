import 'package:flutter/material.dart';

class ProLabel extends StatelessWidget {
  const ProLabel({
    super.key,
    required this.left,
    required this.width,
    required this.top,
  });

  final left;
  final width;
  final top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left, //).305555 is the offset from max screen width
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.red,
        ),
        padding: EdgeInsets.symmetric(
            vertical: width / 200,
            horizontal: width / 80.0),
        child: Text(
          'PRO',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
