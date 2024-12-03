import 'package:flutter/material.dart';
import 'package:revive/presentation/widgets/edited_screen_widgets/top_button_widget.dart';

class VersionType extends StatelessWidget {
  const VersionType({
    super.key,
    required this.x,
    required this.width
  });

  final x;
  final width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: Colors.grey,
          width: 1.5,
        ),
      ),
      // padding: EdgeInsets.all(1.0),
      margin: EdgeInsets.all(width / 80.0),
      child: Row(
          children: [
            TopButton(
              selectedButtonNum: x.selectedButton,
              text: 'Base',
              onTap: () {
                x.selectNewButton(1);
              },
              width: x.selectedButton == 1 ? 1.5 : 0,
              buttonNum: 1,
            ),
            SizedBox(
              width: width / 80.0,
            ),
            TopButton(
              selectedButtonNum: x.selectedButton,
              text: 'v2',
              onTap: () {
                x.selectNewButton(2);
              },
              width: x.selectedButton == 2 ? 1.5 : 0,
              buttonNum: 2,
            ),
            SizedBox(
              width: width / 80.0,
            ),
            TopButton(
              selectedButtonNum: x.selectedButton,
              text: 'v3',
              onTap: () {
                x.selectNewButton(3);
              },
              width: x.selectedButton == 3 ? 1.5 : 0,
              buttonNum: 3,
            ),
          ]
      ),
    );
  }
}
