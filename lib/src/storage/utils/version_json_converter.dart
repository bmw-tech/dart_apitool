import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

/// converts a [Version] to and from Json
class VersionJsonConverter extends JsonConverter<Version, String> {
  const VersionJsonConverter();

  @override
  Version fromJson(String json) {
    return Version.parse(json);
  }

  @override
  String toJson(Version object) {
    return object.canonicalizedVersion;
  }
}
