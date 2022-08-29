/// Error that gets thrown when executing Dart runs into an error
class RunDartError extends Error {
  /// The error message
  final String message;

  /// Creates a new [RunDartError] with the given [message]
  RunDartError(this.message);

  @override
  String toString() {
    return message;
  }
}
