import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:revive/presentation/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/firebase_auth.dart';
import '../../../../utils/constants.dart';
import '../../../view/gallery_access_screen.dart';
import '../../landing_screen_widgets/start_button_widget.dart';
import '../auth_screens_common_widgets/alternate_login_options_widget.dart';
import '../auth_screens_common_widgets/auth_option_widget.dart';
import '../auth_screens_common_widgets/dialog_widget.dart';
import '../auth_screens_common_widgets/top_container_widget.dart';
import '../auth_screens_common_widgets/alternate_login_divider_widget.dart';
import '../auth_screens_common_widgets/text_input_widget.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({
    super.key,
    required this.obscureText,
    required this.togglePassWisibility,
  });

  final obscureText;
  final togglePassWisibility;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final AuthService _auth = AuthService();
    FirebaseAuth auth = FirebaseAuth.instance;

    return SingleChildScrollView(
      child: Column(
        children: [
          TopContainer(
            text1: 'Sign in to your account',
            text2: 'Please provide your account credentials',
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                TextInput(
                  controller: emailController,
                  text: 'Email',
                  obscureText: false,
                  isPass: false,
                  togglePasswordVisibility: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                TextInput(
                  controller: passwordController,
                  text: 'Password',
                  obscureText: obscureText,
                  isPass: true,
                  togglePasswordVisibility: togglePassWisibility,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                StartButtonWidget(
                    text: 'Login',
                    onTap: () async {
                      String email = emailController.text;
                      String password = passwordController.text;
                      // print(email);
                      // print(password);
                      if (email.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogWidget(
                                text: "Please Fill Up Email",
                              );
                            });
                      } else if (password.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogWidget(
                                text: "Please Fill Up Password",
                              );
                            });
                      } else {
                        var user = await auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        String idToken =
                            await auth.currentUser!.getIdToken() ?? "";
                        var client = http.Client();
                        var response = await client.post(
                          Uri.parse(
                              'https://revive-backend-y27xyibz7a-as.a.run.app/auth/login'),
                          headers: <String, String>{
                            "accept": "application/json",
                            "Content-Type": "application/json"
                          },
                          body: jsonEncode(<String, String>{
                            'idToken': idToken,
                            'email': email,
                            'first_name': "",
                            'last_name': "",
                            'country': ''
                          }),
                        );
                        if (response.statusCode == 200) {
                          //   // User signed in successfully
                          //   // Navigate to the next screen or perform necessary actions
                          var body = json.decode(response.body);
                          // print(body);
                          body = body['data'];
                          var ACCESS_TOKEN = body['accessToken'];
                          var REFRESH_TOKEN = body['refreshToken'];
                          print('access_token $ACCESS_TOKEN');
                          print('refresh_token $REFRESH_TOKEN');
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                              'ACCESS_TOKEN', ACCESS_TOKEN);
                          sharedPreferences.setString(
                              'REFRESH_TOKEN', REFRESH_TOKEN);
                          // print(response.statusCode);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }));
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogWidget(
                                  text: "Could Not Sign In",
                                );
                              });
                        }
                      }
                    }),
                SizedBox(
                  height: 60,
                ),
                AlternateLoginDividerWidget(
                  text: 'login',
                ),
                SizedBox(
                  height: 20,
                ),
                AlternateLoginOptions(),
                SizedBox(
                  height: 80,
                ),
                AuthOption(
                  text1: 'Don\'t have an account?',
                  text2: 'Register',
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
