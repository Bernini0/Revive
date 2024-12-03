import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/constants.dart';

class StartButtonWidget extends StatelessWidget {
  StartButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  var onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 2,
          vertical: kDefaultPadding,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(kDefaultPadding * 10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Text(
              text,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Icon(
              FontAwesomeIcons.arrowRight,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
