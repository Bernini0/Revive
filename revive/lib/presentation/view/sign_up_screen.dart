import 'package:flutter/material.dart';

import '../widgets/auth_screen/sign_up_screen_widgets/sign_up_body.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SignUpBody(
        obscureText: _obscureText,
        togglePassWisibility: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}
