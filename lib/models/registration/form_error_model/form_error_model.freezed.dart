// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_error_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FormErrorModel _$RegistrationErrorModelFromJson(
    Map<String, dynamic> json) {
  return _FormErrorModel.fromJson(json);
}

/// @nodoc
mixin _$FormErrorModel {
  List<String>? get username => throw _privateConstructorUsedError;
  List<String>? get email => throw _privateConstructorUsedError;
  List<String>? get phone => throw _privateConstructorUsedError;
  PlainPassword? get plainPassword => throw _privateConstructorUsedError;
  List<String>? get agreeTerms => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegistrationErrorModelCopyWith<FormErrorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationErrorModelCopyWith<$Res> {
  factory $RegistrationErrorModelCopyWith(FormErrorModel value,
          $Res Function(FormErrorModel) then) =
      _$RegistrationErrorModelCopyWithImpl<$Res, FormErrorModel>;
  @useResult
  $Res call(
      {List<String>? username,
      List<String>? email,
      List<String>? phone,
      PlainPassword? plainPassword,
      List<String>? agreeTerms});

  $PlainPasswordCopyWith<$Res>? get plainPassword;
}

/// @nodoc
class _$RegistrationErrorModelCopyWithImpl<$Res,
        $Val extends FormErrorModel>
    implements $RegistrationErrorModelCopyWith<$Res> {
  _$RegistrationErrorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? plainPassword = freezed,
    Object? agreeTerms = freezed,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      plainPassword: freezed == plainPassword
          ? _value.plainPassword
          : plainPassword // ignore: cast_nullable_to_non_nullable
              as PlainPassword?,
      agreeTerms: freezed == agreeTerms
          ? _value.agreeTerms
          : agreeTerms // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlainPasswordCopyWith<$Res>? get plainPassword {
    if (_value.plainPassword == null) {
      return null;
    }

    return $PlainPasswordCopyWith<$Res>(_value.plainPassword!, (value) {
      return _then(_value.copyWith(plainPassword: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RegistrationErrorModelImplCopyWith<$Res>
    implements $RegistrationErrorModelCopyWith<$Res> {
  factory _$$RegistrationErrorModelImplCopyWith(
          _$RegistrationErrorModelImpl value,
          $Res Function(_$RegistrationErrorModelImpl) then) =
      __$$RegistrationErrorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String>? username,
      List<String>? email,
      List<String>? phone,
      PlainPassword? plainPassword,
      List<String>? agreeTerms});

  @override
  $PlainPasswordCopyWith<$Res>? get plainPassword;
}

/// @nodoc
class __$$RegistrationErrorModelImplCopyWithImpl<$Res>
    extends _$RegistrationErrorModelCopyWithImpl<$Res,
        _$RegistrationErrorModelImpl>
    implements _$$RegistrationErrorModelImplCopyWith<$Res> {
  __$$RegistrationErrorModelImplCopyWithImpl(
      _$RegistrationErrorModelImpl _value,
      $Res Function(_$RegistrationErrorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? plainPassword = freezed,
    Object? agreeTerms = freezed,
  }) {
    return _then(_$RegistrationErrorModelImpl(
      username: freezed == username
          ? _value._username
          : username // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      email: freezed == email
          ? _value._email
          : email // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      phone: freezed == phone
          ? _value._phone
          : phone // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      plainPassword: freezed == plainPassword
          ? _value.plainPassword
          : plainPassword // ignore: cast_nullable_to_non_nullable
              as PlainPassword?,
      agreeTerms: freezed == agreeTerms
          ? _value._agreeTerms
          : agreeTerms // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegistrationErrorModelImpl
    with DiagnosticableTreeMixin
    implements _FormErrorModel {
  const _$RegistrationErrorModelImpl(
      {final List<String>? username,
      final List<String>? email,
      final List<String>? phone,
      this.plainPassword,
      final List<String>? agreeTerms})
      : _username = username,
        _email = email,
        _phone = phone,
        _agreeTerms = agreeTerms;

  factory _$RegistrationErrorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegistrationErrorModelImplFromJson(json);

  final List<String>? _username;
  @override
  List<String>? get username {
    final value = _username;
    if (value == null) return null;
    if (_username is EqualUnmodifiableListView) return _username;
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

  final List<String>? _phone;
  @override
  List<String>? get phone {
    final value = _phone;
    if (value == null) return null;
    if (_phone is EqualUnmodifiableListView) return _phone;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final PlainPassword? plainPassword;
  final List<String>? _agreeTerms;
  @override
  List<String>? get agreeTerms {
    final value = _agreeTerms;
    if (value == null) return null;
    if (_agreeTerms is EqualUnmodifiableListView) return _agreeTerms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegistrationErrorModel(username: $username, email: $email, phone: $phone, plainPassword: $plainPassword, agreeTerms: $agreeTerms)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegistrationErrorModel'))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('plainPassword', plainPassword))
      ..add(DiagnosticsProperty('agreeTerms', agreeTerms));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationErrorModelImpl &&
            const DeepCollectionEquality().equals(other._username, _username) &&
            const DeepCollectionEquality().equals(other._email, _email) &&
            const DeepCollectionEquality().equals(other._phone, _phone) &&
            (identical(other.plainPassword, plainPassword) ||
                other.plainPassword == plainPassword) &&
            const DeepCollectionEquality()
                .equals(other._agreeTerms, _agreeTerms));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_username),
      const DeepCollectionEquality().hash(_email),
      const DeepCollectionEquality().hash(_phone),
      plainPassword,
      const DeepCollectionEquality().hash(_agreeTerms));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationErrorModelImplCopyWith<_$RegistrationErrorModelImpl>
      get copyWith => __$$RegistrationErrorModelImplCopyWithImpl<
          _$RegistrationErrorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegistrationErrorModelImplToJson(
      this,
    );
  }
}

abstract class _FormErrorModel implements FormErrorModel {
  const factory _FormErrorModel(
      {final List<String>? username,
      final List<String>? email,
      final List<String>? phone,
      final PlainPassword? plainPassword,
      final List<String>? agreeTerms}) = _$RegistrationErrorModelImpl;

  factory _FormErrorModel.fromJson(Map<String, dynamic> json) =
      _$RegistrationErrorModelImpl.fromJson;

  @override
  List<String>? get username;
  @override
  List<String>? get email;
  @override
  List<String>? get phone;
  @override
  PlainPassword? get plainPassword;
  @override
  List<String>? get agreeTerms;
  @override
  @JsonKey(ignore: true)
  _$$RegistrationErrorModelImplCopyWith<_$RegistrationErrorModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
