import 'package:flutter/material.dart';

import '../widgets/auth_screen/sign_in_screen_widgets/sign_in_body.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SignInBody(
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
