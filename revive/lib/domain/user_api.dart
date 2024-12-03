import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserAPI {
  UserAPI(this.authUser);
  final AuthUser authUser;

  Future<String?> createUser() async {
    final String baseUrl =
        'https://revive-backend-y27xyibz7a-as.a.run.app'; // Replace with your base URL

    try {
      Uri url = Uri.parse("$baseUrl/auth/signup");
      http.Response response = await http.get(url);
      var body = jsonEncode({
        'email': authUser.email,
        "password": authUser.password,
        "firstName": authUser.firstName,
        "lastName": authUser.lastName,
        "country": authUser.country
      });

      print("Body: " + body);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      http
          .post(url, headers: {"Content-Type": "application/json"}, body: body)
          .then((http.Response response) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.contentLength}");
        print(response.headers);
        print(response.request);

        if (response.statusCode == 200) {
          var body = json.decode(response.body);
          // print(body);
          body = body['data'];
          String ACCESS_TOKEN = body['accessToken'];
          String REFRESH_TOKEN = body['refreshToken'];
          print('access_token $ACCESS_TOKEN');
          print('refresh_token $REFRESH_TOKEN');

          sharedPreferences.setString('ACCESS_TOKEN', ACCESS_TOKEN);
          sharedPreferences.setString('REFRESH_TOKEN', REFRESH_TOKEN);

          Map<String, dynamic> data = jsonDecode(response.body);

          print("asd ${data['message']}");
          return data['message'];
        } else {
          print(response.statusCode);
          return "Request failed";
        }
      });
    } catch (e) {
      print("Error: $e");
      return ("An error occurred while creating the user");
    }
  }
}
