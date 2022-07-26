import 'package:args/args.dart';
import 'package:path/path.dart' as path;

void main(List<String> arguments) {
  final listArgParser = ArgParser();

  final parser = ArgParser();
  final listCommandParser = parser.addCommand('list', listArgParser);
  listCommandParser.addOption('root',
      abbr: 'r', mandatory: true, help: 'root directory');

  final argResults = parser.parse(arguments);
  final cmd = argResults.command;
  if (cmd != null) {
    switch (cmd.name) {
      case 'list':
        _handleListCommand(cmd);
        break;
      default:
    }
  }
}

void _handleListCommand(ArgResults cmd) {
  final String rootDir = cmd['root'];
  final absolutePath = path.normalize(path.absolute(rootDir));
  print(absolutePath);
}
