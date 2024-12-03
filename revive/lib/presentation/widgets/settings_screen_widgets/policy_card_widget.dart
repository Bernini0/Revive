import 'package:flutter/material.dart';
import 'package:revive/presentation/widgets/settings_screen_widgets/row_widgets.dart';

class PolicyCard extends StatelessWidget {
  const PolicyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 175,
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
              'Legal',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            RowWidget(address: 'terms', text: 'Terms of Service'),
            RowWidget(address: 'privacy', text: 'Privacy Policy'),
            RowWidget(address: 'priSet', text: 'Privacy Settings'),
          ],
        )
    );
  }
}
