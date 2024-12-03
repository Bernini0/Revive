import 'package:flutter/material.dart';

class ProFeatures extends StatelessWidget {
  const ProFeatures(
      {super.key,
      required this.width,
      required this.icon,
      required this.text,
      required this.onTap});

  final width;
  final icon;
  final text;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Column(
          children: [
            Icon(
              icon,
              size: (width / 80) * 6,
            ),
            SizedBox(
              height: width / 80,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        onTap: onTap);
  }
}
