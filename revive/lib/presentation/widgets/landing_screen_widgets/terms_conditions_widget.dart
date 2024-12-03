import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revive/utils/constants.dart';

class TermsConditionsWidget extends StatelessWidget {
  const TermsConditionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kVerticalPadding,
      ),
      child: RichText(
        text: TextSpan(

            style: Theme.of(context).textTheme.titleSmall,
            children: [
              TextSpan(
                text: 'By continuing you accept our ',
              ),
              TextSpan(
                text: 'Terms of Services',
                style: GoogleFonts.inter(
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Terms of Service tapped');
                  },
              ),
              TextSpan(
                text: ' and acknowledge receipt of our Privacy Policy.',
              ),
            ]
        ),
      ),
    );
  }
}