// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intent_browsable_uris.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IntentBrowsableUris _$IntentBrowsableUrisFromJson(Map<String, dynamic> json) {
  return _IntentBrowsableUris.fromJson(json);
}

/// @nodoc
mixin _$IntentBrowsableUris {
  String get scheme => throw _privateConstructorUsedError;
  String get host => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IntentBrowsableUrisCopyWith<IntentBrowsableUris> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntentBrowsableUrisCopyWith<$Res> {
  factory $IntentBrowsableUrisCopyWith(
          IntentBrowsableUris value, $Res Function(IntentBrowsableUris) then) =
      _$IntentBrowsableUrisCopyWithImpl<$Res, IntentBrowsableUris>;
  @useResult
  $Res call({String scheme, String host});
}

/// @nodoc
class _$IntentBrowsableUrisCopyWithImpl<$Res, $Val extends IntentBrowsableUris>
    implements $IntentBrowsableUrisCopyWith<$Res> {
  _$IntentBrowsableUrisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheme = null,
    Object? host = null,
  }) {
    return _then(_value.copyWith(
      scheme: null == scheme
          ? _value.scheme
          : scheme // ignore: cast_nullable_to_non_nullable
              as String,
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntentBrowsableUrisImplCopyWith<$Res>
    implements $IntentBrowsableUrisCopyWith<$Res> {
  factory _$$IntentBrowsableUrisImplCopyWith(_$IntentBrowsableUrisImpl value,
          $Res Function(_$IntentBrowsableUrisImpl) then) =
      __$$IntentBrowsableUrisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String scheme, String host});
}

/// @nodoc
class __$$IntentBrowsableUrisImplCopyWithImpl<$Res>
    extends _$IntentBrowsableUrisCopyWithImpl<$Res, _$IntentBrowsableUrisImpl>
    implements _$$IntentBrowsableUrisImplCopyWith<$Res> {
  __$$IntentBrowsableUrisImplCopyWithImpl(_$IntentBrowsableUrisImpl _value,
      $Res Function(_$IntentBrowsableUrisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheme = null,
    Object? host = null,
  }) {
    return _then(_$IntentBrowsableUrisImpl(
      scheme: null == scheme
          ? _value.scheme
          : scheme // ignore: cast_nullable_to_non_nullable
              as String,
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntentBrowsableUrisImpl
    with DiagnosticableTreeMixin
    implements _IntentBrowsableUris {
  const _$IntentBrowsableUrisImpl({required this.scheme, required this.host});

  factory _$IntentBrowsableUrisImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntentBrowsableUrisImplFromJson(json);

  @override
  final String scheme;
  @override
  final String host;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IntentBrowsableUris(scheme: $scheme, host: $host)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IntentBrowsableUris'))
      ..add(DiagnosticsProperty('scheme', scheme))
      ..add(DiagnosticsProperty('host', host));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntentBrowsableUrisImpl &&
            (identical(other.scheme, scheme) || other.scheme == scheme) &&
            (identical(other.host, host) || other.host == host));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, scheme, host);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntentBrowsableUrisImplCopyWith<_$IntentBrowsableUrisImpl> get copyWith =>
      __$$IntentBrowsableUrisImplCopyWithImpl<_$IntentBrowsableUrisImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntentBrowsableUrisImplToJson(
      this,
    );
  }
}

abstract class _IntentBrowsableUris implements IntentBrowsableUris {
  const factory _IntentBrowsableUris(
      {required final String scheme,
      required final String host}) = _$IntentBrowsableUrisImpl;

  factory _IntentBrowsableUris.fromJson(Map<String, dynamic> json) =
      _$IntentBrowsableUrisImpl.fromJson;

  @override
  String get scheme;
  @override
  String get host;
  @override
  @JsonKey(ignore: true)
  _$$IntentBrowsableUrisImplCopyWith<_$IntentBrowsableUrisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
