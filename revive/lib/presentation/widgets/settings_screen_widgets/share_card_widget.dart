import 'package:flutter/material.dart';
import 'package:revive/presentation/widgets/settings_screen_widgets/row_widgets.dart';

class ShareCard extends StatelessWidget {
  const ShareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.15)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Social',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            RowWidget(address: 'share', text: 'Share app'),
            RowWidget(address: 'fb', text: 'Facebook'),
            RowWidget(address: 'twitter', text: 'Twitter'),
            RowWidget(address: 'insta', text: 'Instagram'),
          ],
        )
    );
  }
}
