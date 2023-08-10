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
  String get fullname => throw _privateConstructorUsedError;

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
  $Res call({int id, String fullname});
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
    Object? fullname = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fullname: null == fullname
          ? _value.fullname
          : fullname // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProfilePreviewCopyWith<$Res>
    implements $ProfilePreviewCopyWith<$Res> {
  factory _$$_ProfilePreviewCopyWith(
          _$_ProfilePreview value, $Res Function(_$_ProfilePreview) then) =
      __$$_ProfilePreviewCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String fullname});
}

/// @nodoc
class __$$_ProfilePreviewCopyWithImpl<$Res>
    extends _$ProfilePreviewCopyWithImpl<$Res, _$_ProfilePreview>
    implements _$$_ProfilePreviewCopyWith<$Res> {
  __$$_ProfilePreviewCopyWithImpl(
      _$_ProfilePreview _value, $Res Function(_$_ProfilePreview) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullname = null,
  }) {
    return _then(_$_ProfilePreview(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fullname: null == fullname
          ? _value.fullname
          : fullname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProfilePreview
    with DiagnosticableTreeMixin
    implements _ProfilePreview {
  const _$_ProfilePreview({required this.id, required this.fullname});

  factory _$_ProfilePreview.fromJson(Map<String, dynamic> json) =>
      _$$_ProfilePreviewFromJson(json);

  @override
  final int id;
  @override
  final String fullname;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfilePreview(id: $id, fullname: $fullname)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfilePreview'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('fullname', fullname));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProfilePreview &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullname, fullname) ||
                other.fullname == fullname));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, fullname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProfilePreviewCopyWith<_$_ProfilePreview> get copyWith =>
      __$$_ProfilePreviewCopyWithImpl<_$_ProfilePreview>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProfilePreviewToJson(
      this,
    );
  }
}

abstract class _ProfilePreview implements ProfilePreview {
  const factory _ProfilePreview(
      {required final int id,
      required final String fullname}) = _$_ProfilePreview;

  factory _ProfilePreview.fromJson(Map<String, dynamic> json) =
      _$_ProfilePreview.fromJson;

  @override
  int get id;
  @override
  String get fullname;
  @override
  @JsonKey(ignore: true)
  _$$_ProfilePreviewCopyWith<_$_ProfilePreview> get copyWith =>
      throw _privateConstructorUsedError;
}
