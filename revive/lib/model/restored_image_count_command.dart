import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:revive/model/command.dart';
import 'package:revive/presentation/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestoredImageCountCommand implements Command {
  // late File file;
  // RestoreImageCommand({required this.file});

  RestoredImageCountCommand();

  // Future<void> RestoreImage(String signedUrl, File imageFile) async {
  //   try {
  //     var client = http.Client();
  //     var response =
  // }
  Future<void> _restoreInfo() async {
    String? message;
    try {
      // Download image
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String ACCESS_TOKEN = sharedPreferences.get('ACCESS_TOKEN') as String;
      print(ACCESS_TOKEN);
      http.Response response = await http.get(
        Uri.parse(
            'https://revive-backend-y27xyibz7a-as.a.run.app/plan/check-subscription'),
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json",
          "access-token": ACCESS_TOKEN
        },
      );

      print("hi4");
      print(response.body);
      var body = json.decode(response.body);
      var data = body['data'];
      int restore_limit = data['restoreLimit'];
      int restore_count = data['restoreCount'];
      sharedPreferences.setInt('RESTORE_LIMIT', restore_limit);
      sharedPreferences.setInt('RESTORE_COUNT', restore_count);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> execute() async {
    // TODO: implement execute
    await _restoreInfo();
  }
}
