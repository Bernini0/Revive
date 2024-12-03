import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'command.dart';

class UploadImageCommand implements Command {
  late File file;
  late String imageName;
  UploadImageCommand({required this.file, required this.imageName});

  Future<void> uploadImage(String signedUrl, File imageFile) async {
    try {
      final request = http.Request('PUT', Uri.parse(signedUrl));
      request.bodyBytes = await imageFile.readAsBytes();
      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
      } else {
        print('Error uploading image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Future<void> execute() async {
    // Implement the logic to make the API request for uploading images.
    try {
      var client = http.Client();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String ACCESS_TOKEN = sharedPreferences.get('ACCESS_TOKEN') as String;
      print(ACCESS_TOKEN);
      var response = await client.get(
        Uri.parse(
            'https://revive-backend-y27xyibz7a-as.a.run.app/image/urllink/$imageName'),
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json",
          "access-token": ACCESS_TOKEN
        },
      );
      print("res" + response.body);
      var body = json.decode(response.body);
      print(body);
      var data = body['data'] ?? "asdfgsadf";
      // data = jsonDecode(data);
      String signedUrl = data['imageUrl'];
      print("ssss" + signedUrl);
      await uploadImage(signedUrl, file);
    } catch (e) {
      print("excep");
      print(e);
    }
  }
}
