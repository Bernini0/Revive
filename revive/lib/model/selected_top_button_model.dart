import 'package:flutter/foundation.dart';

class SelectedTopButtonModel extends ChangeNotifier {
  int _buttonSelectedNow = 1;

  void selectNewButton(int x) {
    _buttonSelectedNow = x;
    notifyListeners();
  }

  int get selectedButton => _buttonSelectedNow;
}
