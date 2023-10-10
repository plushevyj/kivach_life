// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_preview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProfilePreview _$ProfilePreviewFromJson(Map<String, dynamic> json) {
  return _ProfilePreview.fromJson(json);
}

/// @nodoc
mixin _$ProfilePreview {
  int get id => throw _privateConstructorUsedError;
  String get firstname => throw _privateConstructorUsedError;
  String get lastname => throw _privateConstructorUsedError;
  String? get middlename => throw _privateConstructorUsedError;
  String get birthdate => throw _privateConstructorUsedError;
  String get sex => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfilePreviewCopyWith<ProfilePreview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfilePreviewCopyWith<$Res> {
  factory $ProfilePreviewCopyWith(
          ProfilePreview value, $Res Function(ProfilePreview) then) =
      _$ProfilePreviewCopyWithImpl<$Res, ProfilePreview>;
  @useResult
  $Res call(
      {int id,
      String firstname,
      String lastname,
      String? middlename,
      String birthdate,
      String sex,
      User? user});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$ProfilePreviewCopyWithImpl<$Res, $Val extends ProfilePreview>
    implements $ProfilePreviewCopyWith<$Res> {
  _$ProfilePreviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstname = null,
    Object? lastname = null,
    Object? middlename = freezed,
    Object? birthdate = null,
    Object? sex = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstname: null == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      lastname: null == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String,
      middlename: freezed == middlename
          ? _value.middlename
          : middlename // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: null == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String,
      sex: null == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfilePreviewImplCopyWith<$Res>
    implements $ProfilePreviewCopyWith<$Res> {
  factory _$$ProfilePreviewImplCopyWith(_$ProfilePreviewImpl value,
          $Res Function(_$ProfilePreviewImpl) then) =
      __$$ProfilePreviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String firstname,
      String lastname,
      String? middlename,
      String birthdate,
      String sex,
      User? user});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$ProfilePreviewImplCopyWithImpl<$Res>
    extends _$ProfilePreviewCopyWithImpl<$Res, _$ProfilePreviewImpl>
    implements _$$ProfilePreviewImplCopyWith<$Res> {
  __$$ProfilePreviewImplCopyWithImpl(
      _$ProfilePreviewImpl _value, $Res Function(_$ProfilePreviewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstname = null,
    Object? lastname = null,
    Object? middlename = freezed,
    Object? birthdate = null,
    Object? sex = null,
    Object? user = freezed,
  }) {
    return _then(_$ProfilePreviewImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstname: null == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      lastname: null == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String,
      middlename: freezed == middlename
          ? _value.middlename
          : middlename // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: null == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String,
      sex: null == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfilePreviewImpl
    with DiagnosticableTreeMixin
    implements _ProfilePreview {
  const _$ProfilePreviewImpl(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.middlename,
      required this.birthdate,
      required this.sex,
      required this.user});

  factory _$ProfilePreviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfilePreviewImplFromJson(json);

  @override
  final int id;
  @override
  final String firstname;
  @override
  final String lastname;
  @override
  final String? middlename;
  @override
  final String birthdate;
  @override
  final String sex;
  @override
  final User? user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfilePreview(id: $id, firstname: $firstname, lastname: $lastname, middlename: $middlename, birthdate: $birthdate, sex: $sex, user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfilePreview'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('firstname', firstname))
      ..add(DiagnosticsProperty('lastname', lastname))
      ..add(DiagnosticsProperty('middlename', middlename))
      ..add(DiagnosticsProperty('birthdate', birthdate))
      ..add(DiagnosticsProperty('sex', sex))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfilePreviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastname, lastname) ||
                other.lastname == lastname) &&
            (identical(other.middlename, middlename) ||
                other.middlename == middlename) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, firstname, lastname, middlename, birthdate, sex, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfilePreviewImplCopyWith<_$ProfilePreviewImpl> get copyWith =>
      __$$ProfilePreviewImplCopyWithImpl<_$ProfilePreviewImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfilePreviewImplToJson(
      this,
    );
  }
}

abstract class _ProfilePreview implements ProfilePreview {
  const factory _ProfilePreview(
      {required final int id,
      required final String firstname,
      required final String lastname,
      required final String? middlename,
      required final String birthdate,
      required final String sex,
      required final User? user}) = _$ProfilePreviewImpl;

  factory _ProfilePreview.fromJson(Map<String, dynamic> json) =
      _$ProfilePreviewImpl.fromJson;

  @override
  int get id;
  @override
  String get firstname;
  @override
  String get lastname;
  @override
  String? get middlename;
  @override
  String get birthdate;
  @override
  String get sex;
  @override
  User? get user;
  @override
  @JsonKey(ignore: true)
  _$$ProfilePreviewImplCopyWith<_$ProfilePreviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
