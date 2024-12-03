import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:revive/model/command.dart';
import 'package:path_provider/path_provider.dart';
import 'package:revive/presentation/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorizeImageCommand implements Command {
  // late File file;
  // RestoreImageCommand({required this.file});
  late String imageName;
  late BuildContext context;
  late final file;
  ColorizeImageCommand({required this.imageName, required this.context});
  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<void> _saveImage() async {
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
            'https://revive-backend-y27xyibz7a-as.a.run.app/image/colorize/' +
                imageName),
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
      var imageUrls = url['imageUrls'];
      var imageUrl = imageUrls[0]['image'];
      // print(url);
      // print();
      response = await http.get(Uri.parse(imageUrl));

      // DefaultCacheManager().getImageFile(url, key: 'edited_image');
      // var f = await DefaultCacheManager().getFileFromCache('edited_image');
      // print(f);
      // var f2 = DefaultCacheManager().getFileFromMemory(key)
      final dir = await getTemporaryDirectory();
      print("path " + dir.path);
      print(response.statusCode);
      // Create an image name
      var filename = '${dir.path}/image.jpg';

      // Save to filesystem
      file = File(filename);
      await file.writeAsBytes(response.bodyBytes);
      print('haha');
      // Ask the user to save it
      // final params = SaveFileDialogParams(sourceFilePath: file.path);
      // final finalPath = await FlutterFileDialog.saveFile(params: params);
      final params = await getDownloadPath();
      // print(params.fileName);
      print(params);
      // print(finalPath);
      String restoredFilename = imageName +
          '_filter_' +
          DateTime.now().toString().replaceAll(':', '-') +
          '.jpg';
      String filepath = params! + '/' + restoredFilename;
      filepath.replaceAll(':', '-');

      await sharedPreferences.setString('restored_image_path', filepath);
      await sharedPreferences.setString(
          'restored_image_name', restoredFilename);
      print(filepath);
      final file2 = File(filepath);
      var x = await file.readAsBytes();
      await file2.writeAsBytes(x);
      // if (finalPath != null) {
      //   message = 'Image saved to disk';
      // }
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

  // Future<void> _saveImage() async {
  //   String? message;
  //
  //   try {
  //     // Download image
  //     final http.Response response = await http.get(Uri.parse(
  //         'https://revive-backend-y27xyibz7a-as.a.run.app/image/restored/' +
  //             imageName));
  //     final params = await getDownloadsDirectory();
  //     print(params);
  //     var status = await Permission.storage.status;
  //     if (!status.isGranted) {
  //       await Permission.storage.request();
  //     }
  //
  //     // Get temporary directory
  //     final dir = await getTemporaryDirectory();
  //     print(dir.path);
  //     // Create an image name
  //     var filename = '${dir.path}/image.jpg';
  //
  //     // Save to filesystem
  //     final file = File(filename);
  //     await file.writeAsBytes(response.bodyBytes);
  //
  //     // Ask the user to save it
  //     //
  //     // String filepath = params!.path +
  //     //     '/' +
  //     //     imageName +
  //     //     '_restored_' +
  //     //     DateTime.now().toString() +
  //     //     '.jpg';
  //     // print(filepath);
  //     // final file2 = File(filepath);
  //     // var x = await file.readAsBytes();
  //     // await file2.writeAsBytes(x);
  //     //
  //     // // var bytes = ByteData.view(file.);
  //     // // final buffer = bytes.buffer;
  //     // // save the data in the path
  //     // await file.copy(filepath);
  //
  //     final par = SaveFileDialogParams(sourceFilePath: file.path);
  //     final finalPath = await FlutterFileDialog.saveFile(params: par);
  //
  //     if (finalPath != null) {
  //       message = 'Image saved to disk';
  //     }
  //
  //     //   if (finalPath != null) {
  //     //     message = 'Image saved to disk';
  //     //   }
  //     // } catch (e) {
  //     //   message = 'An error occurred while saving the image';
  //     // }
  //     //
  //     // if (message != null) {
  //     //   scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
  //     print('shesh');
  //   } catch (e) {
  //     print(e);
  //     print("baal");
  //   }
  // }

  @override
  Future<void> execute() async {
    // Implement the logic to make the API request for fetching images.
    await _saveImage();
  }
}
