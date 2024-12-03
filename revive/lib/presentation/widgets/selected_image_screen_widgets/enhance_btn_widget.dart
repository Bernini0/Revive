import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../landing_screen_widgets/start_button_widget.dart';

class EnhanceBtnWidget extends StatelessWidget {
  EnhanceBtnWidget({
    super.key,
    required this.image,
    required this.onTap,
  });

  ImageProvider image;
  var onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 2
            )
          ]
        ),
        child: StartButtonWidget(
          onTap: onTap,
          text: 'Enhance',
        )
      ),
    );
  }
}