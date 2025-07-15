// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package_api_analyzer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FileToAnalyzeEntry {
  String get filePath;
  List<String> get shownNames;
  List<String> get hiddenNames;
  Set<String> get exportedBy;

  /// Create a copy of _FileToAnalyzeEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FileToAnalyzeEntryCopyWith<_FileToAnalyzeEntry> get copyWith =>
      __$FileToAnalyzeEntryCopyWithImpl<_FileToAnalyzeEntry>(
          this as _FileToAnalyzeEntry, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FileToAnalyzeEntry &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            const DeepCollectionEquality()
                .equals(other.shownNames, shownNames) &&
            const DeepCollectionEquality()
                .equals(other.hiddenNames, hiddenNames) &&
            const DeepCollectionEquality()
                .equals(other.exportedBy, exportedBy));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      filePath,
      const DeepCollectionEquality().hash(shownNames),
      const DeepCollectionEquality().hash(hiddenNames),
      const DeepCollectionEquality().hash(exportedBy));

  @override
  String toString() {
    return '_FileToAnalyzeEntry(filePath: $filePath, shownNames: $shownNames, hiddenNames: $hiddenNames, exportedBy: $exportedBy)';
  }
}

/// @nodoc
abstract mixin class _$FileToAnalyzeEntryCopyWith<$Res> {
  factory _$FileToAnalyzeEntryCopyWith(
          _FileToAnalyzeEntry value, $Res Function(_FileToAnalyzeEntry) _then) =
      __$FileToAnalyzeEntryCopyWithImpl;
  @useResult
  $Res call(
      {String filePath,
      List<String> shownNames,
      List<String> hiddenNames,
      Set<String> exportedBy});
}

/// @nodoc
class __$FileToAnalyzeEntryCopyWithImpl<$Res>
    implements _$FileToAnalyzeEntryCopyWith<$Res> {
  __$FileToAnalyzeEntryCopyWithImpl(this._self, this._then);

  final _FileToAnalyzeEntry _self;
  final $Res Function(_FileToAnalyzeEntry) _then;

  /// Create a copy of _FileToAnalyzeEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filePath = null,
    Object? shownNames = null,
    Object? hiddenNames = null,
    Object? exportedBy = null,
  }) {
    return _then(_self.copyWith(
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      shownNames: null == shownNames
          ? _self.shownNames
          : shownNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hiddenNames: null == hiddenNames
          ? _self.hiddenNames
          : hiddenNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      exportedBy: null == exportedBy
          ? _self.exportedBy
          : exportedBy // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [_FileToAnalyzeEntry].
extension _FileToAnalyzeEntryPatterns on _FileToAnalyzeEntry {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(__FileToAnalyzeEntry value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __FileToAnalyzeEntry() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(__FileToAnalyzeEntry value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case __FileToAnalyzeEntry():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(__FileToAnalyzeEntry value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case __FileToAnalyzeEntry() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String filePath, List<String> shownNames,
            List<String> hiddenNames, Set<String> exportedBy)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __FileToAnalyzeEntry() when $default != null:
        return $default(_that.filePath, _that.shownNames, _that.hiddenNames,
            _that.exportedBy);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String filePath, List<String> shownNames,
            List<String> hiddenNames, Set<String> exportedBy)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case __FileToAnalyzeEntry():
        return $default(_that.filePath, _that.shownNames, _that.hiddenNames,
            _that.exportedBy);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String filePath, List<String> shownNames,
            List<String> hiddenNames, Set<String> exportedBy)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case __FileToAnalyzeEntry() when $default != null:
        return $default(_that.filePath, _that.shownNames, _that.hiddenNames,
            _that.exportedBy);
      case _:
        return null;
    }
  }
}

/// @nodoc

class __FileToAnalyzeEntry implements _FileToAnalyzeEntry {
  const __FileToAnalyzeEntry(
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

  /// Create a copy of _FileToAnalyzeEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$_FileToAnalyzeEntryCopyWith<__FileToAnalyzeEntry> get copyWith =>
      __$_FileToAnalyzeEntryCopyWithImpl<__FileToAnalyzeEntry>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is __FileToAnalyzeEntry &&
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

  @override
  String toString() {
    return '_FileToAnalyzeEntry(filePath: $filePath, shownNames: $shownNames, hiddenNames: $hiddenNames, exportedBy: $exportedBy)';
  }
}

/// @nodoc
abstract mixin class _$_FileToAnalyzeEntryCopyWith<$Res>
    implements _$FileToAnalyzeEntryCopyWith<$Res> {
  factory _$_FileToAnalyzeEntryCopyWith(__FileToAnalyzeEntry value,
          $Res Function(__FileToAnalyzeEntry) _then) =
      __$_FileToAnalyzeEntryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String filePath,
      List<String> shownNames,
      List<String> hiddenNames,
      Set<String> exportedBy});
}

/// @nodoc
class __$_FileToAnalyzeEntryCopyWithImpl<$Res>
    implements _$_FileToAnalyzeEntryCopyWith<$Res> {
  __$_FileToAnalyzeEntryCopyWithImpl(this._self, this._then);

  final __FileToAnalyzeEntry _self;
  final $Res Function(__FileToAnalyzeEntry) _then;

  /// Create a copy of _FileToAnalyzeEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? filePath = null,
    Object? shownNames = null,
    Object? hiddenNames = null,
    Object? exportedBy = null,
  }) {
    return _then(__FileToAnalyzeEntry(
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      shownNames: null == shownNames
          ? _self._shownNames
          : shownNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hiddenNames: null == hiddenNames
          ? _self._hiddenNames
          : hiddenNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      exportedBy: null == exportedBy
          ? _self._exportedBy
          : exportedBy // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

// dart format on
