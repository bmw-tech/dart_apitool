import '../model/model.dart';
import 'api_change_code.dart';
import 'api_change_type.dart';

/// Represents one API change
class ApiChange {
  /// the context of this change. This can be the class the changed method belongs to or the method the changed parameter belongs to.
  /// is null for situations where there is no context (like root level functions)
  final List<Declaration> contextTrace;

  /// The affected declaration. This is the declaration that got changed
  final Declaration? affectedDeclaration;

  /// Type of change
  final ApiChangeType type;

  /// A textual description of the change
  final String changeDescription;

  /// Code of the change. This can be used to read more about the reasoning behind this change
  final ApiChangeCode changeCode;

  /// Determines if this change happened in an experimental context
  final bool isExperimental;

  bool get isBreaking {
    return !isExperimental && type.isBreaking;
  }

  /// creates a new ApiChange instance
  ApiChange({
    required this.changeCode,
    required this.contextTrace,
    this.affectedDeclaration,
    required this.changeDescription,
    required this.type,
    required this.isExperimental,
  });

  @override
  String toString() {
    return 'ApiChange(affectedDeclaration: ${affectedDeclaration?.name}, changeDescription: $changeDescription, type: $type)';
  }
}
