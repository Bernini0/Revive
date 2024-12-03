import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {
  const TopButton(
      {super.key,
        required this.selectedButtonNum,
        required this.text,
        required this.onTap,
        required this.width,
        required this.buttonNum});

  final int selectedButtonNum;
  final int buttonNum;
  final String text;
  final onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color:
          selectedButtonNum == buttonNum ? Colors.grey[700] : Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: width != 0.0
              ? Border.all(
              color: Colors.grey,
              width: width,
              strokeAlign: BorderSide.strokeAlignOutside)
              : Border.fromBorderSide(BorderSide.none),
        ),
        padding: EdgeInsets.symmetric(
            vertical: (size.width / 80) * 2, horizontal: size.width / 16),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      onTap: onTap,
    );
  }
}