// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plain_password.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlainPassword _$PlainPasswordFromJson(Map<String, dynamic> json) {
  return _RegistrationErrorModel.fromJson(json);
}

/// @nodoc
mixin _$PlainPassword {
  List<String>? get first => throw _privateConstructorUsedError;
  List<String>? get second => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlainPasswordCopyWith<PlainPassword> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlainPasswordCopyWith<$Res> {
  factory $PlainPasswordCopyWith(
          PlainPassword value, $Res Function(PlainPassword) then) =
      _$PlainPasswordCopyWithImpl<$Res, PlainPassword>;
  @useResult
  $Res call({List<String>? first, List<String>? second});
}

/// @nodoc
class _$PlainPasswordCopyWithImpl<$Res, $Val extends PlainPassword>
    implements $PlainPasswordCopyWith<$Res> {
  _$PlainPasswordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? first = freezed,
    Object? second = freezed,
  }) {
    return _then(_value.copyWith(
      first: freezed == first
          ? _value.first
          : first // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      second: freezed == second
          ? _value.second
          : second // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegistrationErrorModelCopyWith<$Res>
    implements $PlainPasswordCopyWith<$Res> {
  factory _$$_RegistrationErrorModelCopyWith(_$_RegistrationErrorModel value,
          $Res Function(_$_RegistrationErrorModel) then) =
      __$$_RegistrationErrorModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? first, List<String>? second});
}

/// @nodoc
class __$$_RegistrationErrorModelCopyWithImpl<$Res>
    extends _$PlainPasswordCopyWithImpl<$Res, _$_RegistrationErrorModel>
    implements _$$_RegistrationErrorModelCopyWith<$Res> {
  __$$_RegistrationErrorModelCopyWithImpl(_$_RegistrationErrorModel _value,
      $Res Function(_$_RegistrationErrorModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? first = freezed,
    Object? second = freezed,
  }) {
    return _then(_$_RegistrationErrorModel(
      first: freezed == first
          ? _value._first
          : first // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      second: freezed == second
          ? _value._second
          : second // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RegistrationErrorModel
    with DiagnosticableTreeMixin
    implements _RegistrationErrorModel {
  const _$_RegistrationErrorModel(
      {final List<String>? first, final List<String>? second})
      : _first = first,
        _second = second;

  factory _$_RegistrationErrorModel.fromJson(Map<String, dynamic> json) =>
      _$$_RegistrationErrorModelFromJson(json);

  final List<String>? _first;
  @override
  List<String>? get first {
    final value = _first;
    if (value == null) return null;
    if (_first is EqualUnmodifiableListView) return _first;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _second;
  @override
  List<String>? get second {
    final value = _second;
    if (value == null) return null;
    if (_second is EqualUnmodifiableListView) return _second;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PlainPassword(first: $first, second: $second)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PlainPassword'))
      ..add(DiagnosticsProperty('first', first))
      ..add(DiagnosticsProperty('second', second));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegistrationErrorModel &&
            const DeepCollectionEquality().equals(other._first, _first) &&
            const DeepCollectionEquality().equals(other._second, _second));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_first),
      const DeepCollectionEquality().hash(_second));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegistrationErrorModelCopyWith<_$_RegistrationErrorModel> get copyWith =>
      __$$_RegistrationErrorModelCopyWithImpl<_$_RegistrationErrorModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RegistrationErrorModelToJson(
      this,
    );
  }
}

abstract class _RegistrationErrorModel implements PlainPassword {
  const factory _RegistrationErrorModel(
      {final List<String>? first,
      final List<String>? second}) = _$_RegistrationErrorModel;

  factory _RegistrationErrorModel.fromJson(Map<String, dynamic> json) =
      _$_RegistrationErrorModel.fromJson;

  @override
  List<String>? get first;
  @override
  List<String>? get second;
  @override
  @JsonKey(ignore: true)
  _$$_RegistrationErrorModelCopyWith<_$_RegistrationErrorModel> get copyWith =>
      throw _privateConstructorUsedError;
}
