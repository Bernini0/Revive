import 'dart:io';
import 'package:http/http.dart' as http;

import 'command.dart';

class FetchImageCommand implements Command {
  late File file;
  FetchImageCommand({required this.file});
  Future<void> fetchImage(String signedUrl, File imageFile) async {
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
    // Implement the logic to make the API request for fetching images.
  }
}
