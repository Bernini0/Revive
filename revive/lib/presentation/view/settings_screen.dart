import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revive/presentation/widgets/settings_screen_widgets/policy_card_widget.dart';
import 'package:revive/presentation/widgets/settings_screen_widgets/share_card_widget.dart';
import 'package:revive/presentation/widgets/settings_screen_widgets/try_pro_card_widget.dart';

import 'package:http/http.dart' as http;
import '../../core/firebase_auth.dart';
import '../widgets/auth_screen/auth_screens_common_widgets/dialog_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TryProCard(),
            ShareCard(),
            PolicyCard(),
            InkWell(
              onTap: () async {
                User? user = await _auth.signInWithGoogle();

                print('$user');
                if (user != null) {
                  String idToken =
                      await user.getIdToken(true) ?? "sadfh";
                  // print(idToken);

                  var client = http.Client();
                  var response = await client.post(
                    Uri.parse('https://revive-backend-y27xyibz7a-as.a.run.app/auth/login'),
                    headers: <String, String>{
                      "accept": "application/json",
                    },
                    body: jsonEncode(<String, String>{
                      'idToken': idToken,
                    }),
                  );
                  if (response.statusCode == 200) {
                    //   // User signed in successfully
                    //   // Navigate to the next screen or perform necessary actions
                    var body = json.decode(response.body);
                    print(body);
                    body = body['data'];
                    print(response.statusCode);
                  }
                  else{
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogWidget(text: "Could Not Delete account",);
                        }
                    );
                  }
                }
                else{
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogWidget(text: "Please Sign in first",);
                      }
                  );
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person_off_sharp
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Delete Account',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                User? user = await _auth.signInWithGoogle();

                print('$user');
                if (user != null) {
                  String idToken =
                      await user.getIdToken(true) ?? "sadfh";
                  // print(idToken);

                  var client = http.Client();
                  var response = await client.post(
                    Uri.parse('https://revive-backend-y27xyibz7a-as.a.run.app/auth/login'),
                    headers: <String, String>{
                      "accept": "application/json",
                    },
                    body: jsonEncode(<String, String>{
                      'idToken': idToken,
                    }),
                  );
                  if (response.statusCode == 200) {
                    //   // User signed in successfully
                    //   // Navigate to the next screen or perform necessary actions
                    var body = json.decode(response.body);
                    print(body);
                    body = body['data'];
                    print(response.statusCode);
                  }
                  else{
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogWidget(text: "Could Not Delete account",);
                        }
                    );
                  }
                }
                else{
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogWidget(text: "Please Sign in first",);
                      }
                  );
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20
                ),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person_off_sharp,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Delete Account',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}