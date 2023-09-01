import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:console/console.dart';

/// defines a stdout session that supports opening a "window" for subprocesses that has a limited height
class StdoutSession {
  final _utf8Decoder = Utf8Decoder();
  final _utf8Encoder = Utf8Encoder();

  int? _currentWindowSize;
  int? _lastDrawnWindowSize;
  final _windowLines = <String>[];

  Completer<void>? _writeCompleter;

  final bool silent;

  StdoutSession(this.silent);

  /// writes the given [bytes] to the console
  Future write(List<int> bytes) async {
    if (silent) return;
    // make sure that only one write is active at a time (needed for flush to work)
    if (_writeCompleter != null) {
      await _writeCompleter!.future;
    }
    _writeCompleter = Completer();
    final localCompleter = _writeCompleter!;

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
      await stdout.flush();
    } else {
      Console.write(stringContent);
    }

    _writeCompleter = null;
    localCompleter.complete();
  }

  /// writes the given [string] to the console
  Future writeln([String string = ""]) async {
    if (silent) return;
    await write(_utf8Encoder.convert('$string\n'));
  }

  /// opens a subprocess output window with the given [height]
  void openSubprocessOutputWindow({int height = 10}) {
    if (silent) return;
    // only open a subprocess output window if a terminal is attached to stdout
    if (stdout.hasTerminal) {
      _windowLines.clear();
      _currentWindowSize = height;
      _drawWindow();
      Console.hideCursor();
    }
  }

  /// closes the subprocess output window
  void closeSubprocessOutputWindow() {
    if (silent) return;
    if (_currentWindowSize != null) {
      _drawWindow(doClear: true); // erase window
      _windowLines.clear();
      Console.moveCursorUp(_lastDrawnWindowSize!);
      _currentWindowSize = null;
      _lastDrawnWindowSize = null;
      Console.showCursor();
    }
  }

  void _drawWindow({bool doClear = false}) {
    if (silent) return;
    if (_lastDrawnWindowSize != null) {
      Console.moveCursorUp(_lastDrawnWindowSize!);
    }
    Console.setTextColor(Color.GRAY.id);
    _lastDrawnWindowSize = _windowLines.length;
    for (var i = 0; i < _windowLines.length; i++) {
      Console.eraseLine(2);
      if (!doClear) {
        Console.write('> ${_windowLines[i]}');
      }
      Console.moveCursorDown();
      Console.moveToColumn(0);
    }
    Console.resetTextColor();
  }
}
