import 'dart:collection';

import 'command.dart';

class ApiRequestInvoker {
  final List<Command> _commandQueue = [];
  int index = -1;
  int executing = 0;
  void addCommand(Command command) {
    _commandQueue.add(command);
    index += 1;
  }

  Future<void> executeCommands() async {
    // for (var command in _commandQueue) {
    //   await command.execute();
    //   // _commandQueue.pop()
    // }
    // _commandQueue.
    while (index != -1) {
      var command = _commandQueue[executing];
      await command.execute();
      index--;
      executing++;
      if (index == -1) {
        executing = 0;
        print('baal');
      }
      print('index $index');
      print('executing $executing');
    }

    // await _commandQueue.forEach((command) async {
    //   await command.execute();
    // });
    // _commandQueue.clear();
  }
}
