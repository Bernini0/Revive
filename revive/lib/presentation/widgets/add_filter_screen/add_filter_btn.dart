import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../landing_screen_widgets/start_button_widget.dart';

class AddFilterBtnWidget extends StatelessWidget {
  AddFilterBtnWidget(
      {super.key,
      required this.image,
      required this.onTap,
      required this.width});

  ImageProvider image;
  var onTap;
  final width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding / 2),
      child: Container(
          height: 40,
          width: width,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 2)
              ]),
          child: StartButtonWidget(
            onTap: onTap,
            text: 'Add Filter',
          )),
    );
  }
}
