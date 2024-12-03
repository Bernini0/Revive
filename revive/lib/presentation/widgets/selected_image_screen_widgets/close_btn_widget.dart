import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class CloseBtnWidget extends StatelessWidget {
  const CloseBtnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding, vertical: kVerticalPadding),
      child: Container(
        width: 32, // Adjust the size of the circle container as needed
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.5),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
