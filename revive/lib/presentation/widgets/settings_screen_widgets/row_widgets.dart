import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({super.key, required this.address, required this.text});

  final address;
  final text;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/icons/${address}.svg',
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        SvgPicture.asset(
          'assets/icons/export.svg',
          height: 15,
        )
      ],
    );
  }
}
