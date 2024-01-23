// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_error_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ResetPasswordErrorModel _$ResetPasswordErrorModelFromJson(
    Map<String, dynamic> json) {
  return _ResetPasswordErrorModel.fromJson(json);
}

/// @nodoc
mixin _$ResetPasswordErrorModel {
  List<String>? get phone => throw _privateConstructorUsedError;
  List<String>? get email => throw _privateConstructorUsedError;
  int? get remainingTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResetPasswordErrorModelCopyWith<ResetPasswordErrorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordErrorModelCopyWith<$Res> {
  factory $ResetPasswordErrorModelCopyWith(ResetPasswordErrorModel value,
          $Res Function(ResetPasswordErrorModel) then) =
      _$ResetPasswordErrorModelCopyWithImpl<$Res, ResetPasswordErrorModel>;
  @useResult
  $Res call({List<String>? phone, List<String>? email, int? remainingTime});
}

/// @nodoc
class _$ResetPasswordErrorModelCopyWithImpl<$Res,
        $Val extends ResetPasswordErrorModel>
    implements $ResetPasswordErrorModelCopyWith<$Res> {
  _$ResetPasswordErrorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = freezed,
    Object? email = freezed,
    Object? remainingTime = freezed,
  }) {
    return _then(_value.copyWith(
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      remainingTime: freezed == remainingTime
          ? _value.remainingTime
          : remainingTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResetPasswordErrorModelImplCopyWith<$Res>
    implements $ResetPasswordErrorModelCopyWith<$Res> {
  factory _$$ResetPasswordErrorModelImplCopyWith(
          _$ResetPasswordErrorModelImpl value,
          $Res Function(_$ResetPasswordErrorModelImpl) then) =
      __$$ResetPasswordErrorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? phone, List<String>? email, int? remainingTime});
}

/// @nodoc
class __$$ResetPasswordErrorModelImplCopyWithImpl<$Res>
    extends _$ResetPasswordErrorModelCopyWithImpl<$Res,
        _$ResetPasswordErrorModelImpl>
    implements _$$ResetPasswordErrorModelImplCopyWith<$Res> {
  __$$ResetPasswordErrorModelImplCopyWithImpl(
      _$ResetPasswordErrorModelImpl _value,
      $Res Function(_$ResetPasswordErrorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = freezed,
    Object? email = freezed,
    Object? remainingTime = freezed,
  }) {
    return _then(_$ResetPasswordErrorModelImpl(
      phone: freezed == phone
          ? _value._phone
          : phone // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      email: freezed == email
          ? _value._email
          : email // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      remainingTime: freezed == remainingTime
          ? _value.remainingTime
          : remainingTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResetPasswordErrorModelImpl
    with DiagnosticableTreeMixin
    implements _ResetPasswordErrorModel {
  const _$ResetPasswordErrorModelImpl(
      {final List<String>? phone,
      final List<String>? email,
      this.remainingTime})
      : _phone = phone,
        _email = email;

  factory _$ResetPasswordErrorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetPasswordErrorModelImplFromJson(json);

  final List<String>? _phone;
  @override
  List<String>? get phone {
    final value = _phone;
    if (value == null) return null;
    if (_phone is EqualUnmodifiableListView) return _phone;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _email;
  @override
  List<String>? get email {
    final value = _email;
    if (value == null) return null;
    if (_email is EqualUnmodifiableListView) return _email;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? remainingTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ResetPasswordErrorModel(phone: $phone, email: $email, remainingTime: $remainingTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ResetPasswordErrorModel'))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('remainingTime', remainingTime));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordErrorModelImpl &&
            const DeepCollectionEquality().equals(other._phone, _phone) &&
            const DeepCollectionEquality().equals(other._email, _email) &&
            (identical(other.remainingTime, remainingTime) ||
                other.remainingTime == remainingTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_phone),
      const DeepCollectionEquality().hash(_email),
      remainingTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordErrorModelImplCopyWith<_$ResetPasswordErrorModelImpl>
      get copyWith => __$$ResetPasswordErrorModelImplCopyWithImpl<
          _$ResetPasswordErrorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPasswordErrorModelImplToJson(
      this,
    );
  }
}

abstract class _ResetPasswordErrorModel implements ResetPasswordErrorModel {
  const factory _ResetPasswordErrorModel(
      {final List<String>? phone,
      final List<String>? email,
      final int? remainingTime}) = _$ResetPasswordErrorModelImpl;

  factory _ResetPasswordErrorModel.fromJson(Map<String, dynamic> json) =
      _$ResetPasswordErrorModelImpl.fromJson;

  @override
  List<String>? get phone;
  @override
  List<String>? get email;
  @override
  int? get remainingTime;
  @override
  @JsonKey(ignore: true)
  _$$ResetPasswordErrorModelImplCopyWith<_$ResetPasswordErrorModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
