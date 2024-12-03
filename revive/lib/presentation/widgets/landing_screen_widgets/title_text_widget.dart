import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:revive/utils/constants.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kVerticalPadding
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleLarge ?? TextStyle(),
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          stopPauseOnTap: true,
          animatedTexts: [
            TyperAnimatedText(
              'Transform your photos with a single tap',
              speed: Duration(milliseconds: 50),
              textAlign: TextAlign.left,
              curve: Curves.easeInCubic,
            ),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
}