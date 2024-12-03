import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:revive/model/command.dart';
import 'package:revive/presentation/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserInfoCommand implements Command {
  // late File file;
  // RestoreImageCommand({required this.file});

  late BuildContext context;
  GetUserInfoCommand({required this.context});
  // Future<void> RestoreImage(String signedUrl, File imageFile) async {
  //   try {
  //     var client = http.Client();
  //     var response =
  // }
  Future<void> _userInfo() async {
    String? message;
    print("hi");
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    print("hi2");
    try {
      // Download image
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String ACCESS_TOKEN = sharedPreferences.get('ACCESS_TOKEN') as String;
      print(ACCESS_TOKEN);
      http.Response response = await http.get(
        Uri.parse(
            'https://revive-backend-y27xyibz7a-as.a.run.app/auth/get_user_info'),
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json",
          "access-token": ACCESS_TOKEN
        },
      );

      print("hi4");
      // var status = await Permission.storage.status;
      // print(status);
      // if (!status.isGranted) {
      //   _getStoragePermission();
      // }

      // Get temporary directory
      print(response.body);
      var body = json.decode(response.body);
      var url = body['data'];
      print(url);
      if (body['success'] == true) {
        sharedPreferences.setBool('LOGGED_IN', true);
      } else {
        String REFRESH_TOKEN = sharedPreferences.get('REFRESH_TOKEN') as String;

        http.Response response2 = await http.get(
          Uri.parse(
              'https://revive-backend-y27xyibz7a-as.a.run.app/auth/refresh_tokens'),
          headers: <String, String>{
            "accept": "application/json",
            "Content-Type": "application/json",
            "refresh-token": REFRESH_TOKEN
          },
        );
        var body2 = json.decode(response2.body);
        if (body2['success'] == true) {
          var data = body2['data'];
          ACCESS_TOKEN = data['accessToken'];
          REFRESH_TOKEN = data['refreshToken'];
          sharedPreferences.setString('ACCESS_TOKEN', ACCESS_TOKEN);
          sharedPreferences.setString('REFRESH_TOKEN', ACCESS_TOKEN);
          sharedPreferences.setBool('LOGGED_IN', true);
        } else {
          sharedPreferences.setBool('LOGGED_IN', false);
        }
      }
    } catch (e) {
      message = 'An error occurred while saving the image';
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.toString())));
      print(e.toString());
      AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ),
              );
            },
          ),
        ],
      );
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text('saved')));
    }
  }

  @override
  Future<void> execute() async {
    // Implement the logic to make the API request for fetching images.
    await _userInfo();
  }
}
