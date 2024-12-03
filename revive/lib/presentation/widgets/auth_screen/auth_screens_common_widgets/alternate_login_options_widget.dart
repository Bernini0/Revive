import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revive/presentation/widgets/auth_screen/auth_screens_common_widgets/dialog_widget.dart';
import 'package:revive/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/firebase_auth.dart';
import '../../../view/gallery_access_screen.dart';

// SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
// String ACCESS_TOKEN = SharedPreferences.getInstance().;
// String REFRESH_TOKEN = "";

class AlternateLoginOptions extends StatefulWidget {
  @override
  State<AlternateLoginOptions> createState() => _AlternateLoginOptionsState();
}

class _AlternateLoginOptionsState extends State<AlternateLoginOptions> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    bool circularProcess = false;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  setState(() {
                    circularProcess = true;
                  });
                  User? user = await _auth.signInWithGoogle();
                  setState(() {
                    circularProcess = false;
                  });
                  print('usernt $user');
                  if (user != null) {
                    String email = user.email ?? "abcd";
                    String idToken = await user.getIdToken(true) ?? "sadfh";
                    print("asasasasasas: " + idToken);

                    var client = http.Client();
                    print(email);
                    print(user.displayName);
                    developer.log(idToken, name: 'Id token');
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
                        'first_name': user.displayName ?? 'ancd',
                        'last_name': user.displayName ?? 'ancd',
                        'country': 'Bangladesh'
                      }),
                    );
                    if (response.statusCode == 200) {
                      //   // User signed in successfully
                      //   // Navigate to the next screen or perform necessary actions
                      var body = json.decode(response.body);
                      print(body);
                      body = body['data'];
                      var ACCESS_TOKEN = body['accessToken'];
                      var REFRESH_TOKEN = body['refreshToken'];
                      print('access_token $ACCESS_TOKEN');
                      print('refresh_token $REFRESH_TOKEN');
                      print(response.statusCode);
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString('ACCESS_TOKEN', ACCESS_TOKEN);
                      sharedPreferences.setString(
                          'REFRESH_TOKEN', REFRESH_TOKEN);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return GalleryAccessScreen();
                      }));
                    } else {
                      print('popopop: ${response.body}');

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DialogWidget(
                              text: "Could Not Sign In",
                            );
                          });
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(kDefaultPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/google.svg',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Google',
                        style: Theme.of(context).textTheme.labelSmall,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/apple.svg',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Apple',
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        circularProcess
            ? CircularProgressIndicator(
                color: kPrimary,
              )
            : SizedBox(
                height: 5,
              ),
      ],
    );
  }
}
