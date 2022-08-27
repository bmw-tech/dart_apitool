/// Base class for all internal declarations
abstract class InternalDeclaration {
  /// [id] of this declaration
  int get id;

  /// [id] of the parent class or [null] if there is none
  int? get parentClassId;
}
