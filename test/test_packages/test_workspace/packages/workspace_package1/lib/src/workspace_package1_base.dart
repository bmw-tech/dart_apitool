import 'package:path/path.dart' as p;

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
  String get awesomePath => p.join('awesome', 'path');
}
