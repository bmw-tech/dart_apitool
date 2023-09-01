enum OutputMode {
  humanReadable._('human-readable'),
  json._('json');

  final String optionName;

  const OutputMode._(this.optionName);
}
