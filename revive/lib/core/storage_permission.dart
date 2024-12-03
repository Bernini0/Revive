import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionGetter {
  static Future<bool> promptPermissionSetting() async {
    if (Platform.isIOS) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }
    }
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted ||
          (await Permission.photos.request().isGranted &&
              await Permission.videos.request().isGranted)) {
        return true;
      }
    }
    return false;
  }
}
