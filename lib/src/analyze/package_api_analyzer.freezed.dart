// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package_api_analyzer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FileToAnalyzeEntry {
  String get filePath => throw _privateConstructorUsedError;
  List<String> get shownNames => throw _privateConstructorUsedError;
  List<String> get hiddenNames => throw _privateConstructorUsedError;
  Set<String> get exportedBy => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  _$FileToAnalyzeEntryCopyWith<_FileToAnalyzeEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FileToAnalyzeEntryCopyWith<$Res> {
  factory _$FileToAnalyzeEntryCopyWith(
          _FileToAnalyzeEntry value, $Res Function(_FileToAnalyzeEntry) then) =
      __$FileToAnalyzeEntryCopyWithImpl<$Res, _FileToAnalyzeEntry>;
  @useResult
  $Res call(
      {String filePath,
      List<String> shownNames,
      List<String> hiddenNames,
      Set<String> exportedBy});
}

/// @nodoc
class __$FileToAnalyzeEntryCopyWithImpl<$Res, $Val extends _FileToAnalyzeEntry>
    implements _$FileToAnalyzeEntryCopyWith<$Res> {
  __$FileToAnalyzeEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filePath = null,
    Object? shownNames = null,
    Object? hiddenNames = null,
    Object? exportedBy = null,
  }) {
    return _then(_value.copyWith(
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      shownNames: null == shownNames
          ? _value.shownNames
          : shownNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hiddenNames: null == hiddenNames
          ? _value.hiddenNames
          : hiddenNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      exportedBy: null == exportedBy
          ? _value.exportedBy
          : exportedBy // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FileToAnalyzeEntryImplCopyWith<$Res>
    implements _$FileToAnalyzeEntryCopyWith<$Res> {
  factory _$$_FileToAnalyzeEntryImplCopyWith(_$_FileToAnalyzeEntryImpl value,
          $Res Function(_$_FileToAnalyzeEntryImpl) then) =
      __$$_FileToAnalyzeEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String filePath,
      List<String> shownNames,
      List<String> hiddenNames,
      Set<String> exportedBy});
}

/// @nodoc
class __$$_FileToAnalyzeEntryImplCopyWithImpl<$Res>
    extends __$FileToAnalyzeEntryCopyWithImpl<$Res, _$_FileToAnalyzeEntryImpl>
    implements _$$_FileToAnalyzeEntryImplCopyWith<$Res> {
  __$$_FileToAnalyzeEntryImplCopyWithImpl(_$_FileToAnalyzeEntryImpl _value,
      $Res Function(_$_FileToAnalyzeEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filePath = null,
    Object? shownNames = null,
    Object? hiddenNames = null,
    Object? exportedBy = null,
  }) {
    return _then(_$_FileToAnalyzeEntryImpl(
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      shownNames: null == shownNames
          ? _value._shownNames
          : shownNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hiddenNames: null == hiddenNames
          ? _value._hiddenNames
          : hiddenNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      exportedBy: null == exportedBy
          ? _value._exportedBy
          : exportedBy // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc

class _$_FileToAnalyzeEntryImpl implements __FileToAnalyzeEntry {
  const _$_FileToAnalyzeEntryImpl(
      {required this.filePath,
      final List<String> shownNames = const [],
      final List<String> hiddenNames = const [],
      required final Set<String> exportedBy})
      : _shownNames = shownNames,
        _hiddenNames = hiddenNames,
        _exportedBy = exportedBy;

  @override
  final String filePath;
  final List<String> _shownNames;
  @override
  @JsonKey()
  List<String> get shownNames {
    if (_shownNames is EqualUnmodifiableListView) return _shownNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shownNames);
  }

  final List<String> _hiddenNames;
  @override
  @JsonKey()
  List<String> get hiddenNames {
    if (_hiddenNames is EqualUnmodifiableListView) return _hiddenNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hiddenNames);
  }

  final Set<String> _exportedBy;
  @override
  Set<String> get exportedBy {
    if (_exportedBy is EqualUnmodifiableSetView) return _exportedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_exportedBy);
  }

  @override
  String toString() {
    return '_FileToAnalyzeEntry(filePath: $filePath, shownNames: $shownNames, hiddenNames: $hiddenNames, exportedBy: $exportedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FileToAnalyzeEntryImpl &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            const DeepCollectionEquality()
                .equals(other._shownNames, _shownNames) &&
            const DeepCollectionEquality()
                .equals(other._hiddenNames, _hiddenNames) &&
            const DeepCollectionEquality()
                .equals(other._exportedBy, _exportedBy));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      filePath,
      const DeepCollectionEquality().hash(_shownNames),
      const DeepCollectionEquality().hash(_hiddenNames),
      const DeepCollectionEquality().hash(_exportedBy));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FileToAnalyzeEntryImplCopyWith<_$_FileToAnalyzeEntryImpl> get copyWith =>
      __$$_FileToAnalyzeEntryImplCopyWithImpl<_$_FileToAnalyzeEntryImpl>(
          this, _$identity);
}

abstract class __FileToAnalyzeEntry implements _FileToAnalyzeEntry {
  const factory __FileToAnalyzeEntry(
      {required final String filePath,
      final List<String> shownNames,
      final List<String> hiddenNames,
      required final Set<String> exportedBy}) = _$_FileToAnalyzeEntryImpl;

  @override
  String get filePath;
  @override
  List<String> get shownNames;
  @override
  List<String> get hiddenNames;
  @override
  Set<String> get exportedBy;
  @override
  @JsonKey(ignore: true)
  _$$_FileToAnalyzeEntryImplCopyWith<_$_FileToAnalyzeEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
