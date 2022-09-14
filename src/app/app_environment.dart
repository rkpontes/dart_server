import 'dart:io';

class AppEnv {
  final Map<String, String> _map = {};
  final String filePath;

  AppEnv(this.filePath, {Map<String, String>? mocks}) {
    if (mocks == null) {
      _init();
    } else {
      _map.addAll(mocks);
    }
  }

  void _init() {
    final file = File(filePath);
    final envText = file.readAsStringSync();

    for (var line in envText.split('\n')) {
      if (line.isEmpty) {
        continue;
      }

      final lineBreak = line.split('=');
      if (lineBreak.length != 2) {
        continue;
      }
      _map[lineBreak[0]] = lineBreak[1].trim();
    }
  }

  String? operator [](String key) {
    return _map[key];
  }
}
