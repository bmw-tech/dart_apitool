import 'dart:io';

import 'package:colorize/colorize.dart';

/// Utility class for handling colored terminal output.
/// Automatically detects if stdout/stderr are attached to a terminal
/// and disables colors when output is piped to a file.
class ColorUtils {
  /// Whether colors should be enabled for stdout
  static bool get shouldUseColorsForStdout =>
      stdioType(stdout) == StdioType.terminal;

  /// Whether colors should be enabled for stderr
  static bool get shouldUseColorsForStderr =>
      stdioType(stderr) == StdioType.terminal;

  /// Creates a colorized string for stdout output.
  /// If stdout is not a terminal, returns the plain text without colors.
  static String colorizeForStdout(
      String text, Colorize Function(Colorize) style) {
    if (shouldUseColorsForStdout) {
      return style(Colorize(text)).toString();
    }
    return text;
  }

  /// Creates a colorized string for stderr output.
  /// If stderr is not a terminal, returns the plain text without colors.
  static String colorizeForStderr(
      String text, Colorize Function(Colorize) style) {
    if (shouldUseColorsForStderr) {
      return style(Colorize(text)).toString();
    }
    return text;
  }

  /// Convenience method for green text on stdout
  static String green(String text) => colorizeForStdout(text, (c) => c.green());

  /// Convenience method for red text on stdout
  static String red(String text) => colorizeForStdout(text, (c) => c.red());

  /// Convenience method for bold text on stdout
  static String bold(String text) => colorizeForStdout(text, (c) => c.bold());

  /// Convenience method for italic text on stdout
  static String italic(String text) =>
      colorizeForStdout(text, (c) => c.italic());

  /// Convenience method for red text on stderr
  static String redError(String text) =>
      colorizeForStderr(text, (c) => c.red());

  /// Convenience method for bold red text on stderr
  static String boldRedError(String text) =>
      colorizeForStderr(text, (c) => c.red().bold());
}
