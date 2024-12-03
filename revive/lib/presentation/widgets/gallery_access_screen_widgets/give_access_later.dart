import 'package:flutter/material.dart';
import '../../view/home_screen.dart';

class GiveAccessLater extends StatelessWidget {
  const GiveAccessLater({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      },
      child: Text(
        'I’ll do it later',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}