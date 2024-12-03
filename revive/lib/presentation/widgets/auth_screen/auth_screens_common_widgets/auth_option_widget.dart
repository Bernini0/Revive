import 'package:flutter/material.dart';
import 'package:revive/presentation/view/sign_in_screen.dart';
import 'package:revive/presentation/view/sign_up_screen.dart';

import '../../../../utils/constants.dart';


class AuthOption extends StatelessWidget {
  const AuthOption({
    super.key,
    required this.text1,
    required this.text2
  });

  final text1, text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        InkWell(
          onTap: (){
            Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return text2 == 'Register' ? SignUpScreen() : SignInScreen();
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInCirc;


                    var slideTween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var fadeTween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(slideTween),
                      child: FadeTransition(
                        opacity: animation.drive(fadeTween),
                        child: child,
                      ),
                    );
                  },
                ),
            );
          },
          child: Text(
            ' ${text2}',
            style: TextStyle(
              color: kPrimary,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.20,
            ),
          ),
        )
      ],
    );
  }
}
