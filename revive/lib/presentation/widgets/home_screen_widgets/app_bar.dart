import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revive/presentation/view/sign_in_screen.dart';

import '../../../utils/constants.dart';

AppBar buildAppBar(BuildContext context) {
    return AppBar(
      titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      title: Text(
        'Enhance',
      ),
      actions: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kHorizontalPadding / 2),
          child: InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return SignInScreen();
                  }));
            },
            child: Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }