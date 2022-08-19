class RunDartError extends Error {
  final String message;

  RunDartError(this.message);

  @override
  String toString() {
    return message;
  }
}
