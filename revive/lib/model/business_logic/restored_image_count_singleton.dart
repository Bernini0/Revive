import 'package:revive/model/api_invoker.dart';
import 'package:revive/model/restored_image_count_command.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestoredImageCount {
  static RestoredImageCount _instance = RestoredImageCount._internal();
  late int _restored_limit;
  late int _restored_count;

  RestoredImageCount._internal() {
    //Fetch From API
    //Right now dummy values
    _restored_limit = 10;
    _restored_count = 0;
  }
  static Future<RestoredImageCount> internal() async {
    if (_instance == null) {
      _instance = RestoredImageCount._internal();
      var invoker = ApiRequestInvoker();
      invoker.addCommand(RestoredImageCountCommand());
      await invoker.executeCommands();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      _instance._restored_count =
          sharedPreferences.getInt('RESTORE_COUNT') as int;
      _instance._restored_limit = sharedPreferences.get('RESTORE_LIMIT') as int;
    }
    return _instance;
  }

  int get restored_count => _restored_count;
  int get restored_limit => _restored_limit;

  void increment_image_count() {
    _restored_count++;
  }
}
