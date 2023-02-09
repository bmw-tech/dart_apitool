import 'dart:convert';

import 'package:console/console.dart';

/// defines a stdout session that supports opening a "window" for subprocesses that has a limited height
class StdoutSession {
  final _utf8Decoder = Utf8Decoder();
  final _utf8Encoder = Utf8Encoder();

  int? _currentWindowSize;
  final _windowLines = <String>[];

  /// writes the given [bytes] to the console
  void write(List<int> bytes) {
    String stringContent = _utf8Decoder.convert(bytes);
    if (_currentWindowSize != null) {
      if (stringContent.length > 1 && stringContent.endsWith('\n')) {
        stringContent = stringContent.substring(0, stringContent.length - 1);
      }
      _windowLines.addAll(stringContent.split('\n'));
      while (_windowLines.length > _currentWindowSize!) {
        _windowLines.removeAt(0);
      }
      _drawWindow();
    } else {
      Console.write(stringContent);
    }
  }

  /// writes the given [string] to the console
  void writeln([String string = ""]) {
    write(_utf8Encoder.convert('$string\n'));
  }

  /// opens a subprocess output window with the given [height]
  void openSubprocessOutputWindow({int height = 10}) {
    _windowLines.clear();
    _currentWindowSize = height;
    _drawWindow(moveCursorUp: false);
  }

  /// closes the subprocess output window
  void closeSubprocessOutputWindow() {
    if (_currentWindowSize != null) {
      _windowLines.clear();
      _drawWindow(doClear: true); // erase window
      Console.moveCursorUp(_currentWindowSize!);
      _currentWindowSize = null;
    }
  }

  void _drawWindow({bool moveCursorUp = true, bool doClear = false}) {
    if (moveCursorUp) {
      Console.moveCursorUp(_currentWindowSize!);
    }
    Console.setTextColor(Color.GRAY.id);
    for (var i = 0; i < _currentWindowSize!; i++) {
      Console.eraseLine(2);
      if (!doClear) {
        if (i < _windowLines.length) {
          Console.write('> ${_windowLines[i]}');
        } else {
          Console.write('>');
        }
      }
      Console.moveCursorDown();
      Console.moveToColumn(0);
    }
    Console.resetTextColor();
  }
}
