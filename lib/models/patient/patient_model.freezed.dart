// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return _Patient.fromJson(json);
}

/// @nodoc
mixin _$Patient {
  String get firstname => throw _privateConstructorUsedError;
  String get lastname => throw _privateConstructorUsedError;
  String get middlename => throw _privateConstructorUsedError;
  String get birthdate => throw _privateConstructorUsedError;
  String get sex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PatientCopyWith<Patient> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientCopyWith<$Res> {
  factory $PatientCopyWith(Patient value, $Res Function(Patient) then) =
      _$PatientCopyWithImpl<$Res, Patient>;
  @useResult
  $Res call(
      {String firstname,
      String lastname,
      String middlename,
      String birthdate,
      String sex});
}

/// @nodoc
class _$PatientCopyWithImpl<$Res, $Val extends Patient>
    implements $PatientCopyWith<$Res> {
  _$PatientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstname = null,
    Object? lastname = null,
    Object? middlename = null,
    Object? birthdate = null,
    Object? sex = null,
  }) {
    return _then(_value.copyWith(
      firstname: null == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      lastname: null == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String,
      middlename: null == middlename
          ? _value.middlename
          : middlename // ignore: cast_nullable_to_non_nullable
              as String,
      birthdate: null == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String,
      sex: null == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PatientCopyWith<$Res> implements $PatientCopyWith<$Res> {
  factory _$$_PatientCopyWith(
          _$_Patient value, $Res Function(_$_Patient) then) =
      __$$_PatientCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String firstname,
      String lastname,
      String middlename,
      String birthdate,
      String sex});
}

/// @nodoc
class __$$_PatientCopyWithImpl<$Res>
    extends _$PatientCopyWithImpl<$Res, _$_Patient>
    implements _$$_PatientCopyWith<$Res> {
  __$$_PatientCopyWithImpl(_$_Patient _value, $Res Function(_$_Patient) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstname = null,
    Object? lastname = null,
    Object? middlename = null,
    Object? birthdate = null,
    Object? sex = null,
  }) {
    return _then(_$_Patient(
      firstname: null == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      lastname: null == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String,
      middlename: null == middlename
          ? _value.middlename
          : middlename // ignore: cast_nullable_to_non_nullable
              as String,
      birthdate: null == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String,
      sex: null == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Patient with DiagnosticableTreeMixin implements _Patient {
  const _$_Patient(
      {required this.firstname,
      required this.lastname,
      required this.middlename,
      required this.birthdate,
      required this.sex});

  factory _$_Patient.fromJson(Map<String, dynamic> json) =>
      _$$_PatientFromJson(json);

  @override
  final String firstname;
  @override
  final String lastname;
  @override
  final String middlename;
  @override
  final String birthdate;
  @override
  final String sex;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Patient(firstname: $firstname, lastname: $lastname, middlename: $middlename, birthdate: $birthdate, sex: $sex)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Patient'))
      ..add(DiagnosticsProperty('firstname', firstname))
      ..add(DiagnosticsProperty('lastname', lastname))
      ..add(DiagnosticsProperty('middlename', middlename))
      ..add(DiagnosticsProperty('birthdate', birthdate))
      ..add(DiagnosticsProperty('sex', sex));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Patient &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastname, lastname) ||
                other.lastname == lastname) &&
            (identical(other.middlename, middlename) ||
                other.middlename == middlename) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.sex, sex) || other.sex == sex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, firstname, lastname, middlename, birthdate, sex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PatientCopyWith<_$_Patient> get copyWith =>
      __$$_PatientCopyWithImpl<_$_Patient>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PatientToJson(
      this,
    );
  }
}

abstract class _Patient implements Patient {
  const factory _Patient(
      {required final String firstname,
      required final String lastname,
      required final String middlename,
      required final String birthdate,
      required final String sex}) = _$_Patient;

  factory _Patient.fromJson(Map<String, dynamic> json) = _$_Patient.fromJson;

  @override
  String get firstname;
  @override
  String get lastname;
  @override
  String get middlename;
  @override
  String get birthdate;
  @override
  String get sex;
  @override
  @JsonKey(ignore: true)
  _$$_PatientCopyWith<_$_Patient> get copyWith =>
      throw _privateConstructorUsedError;
}
