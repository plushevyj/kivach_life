// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navbar_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NavbarModel _$NavbarModelFromJson(Map<String, dynamic> json) {
  return _NavbarModel.fromJson(json);
}

/// @nodoc
mixin _$NavbarModel {
  String get icon => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get route => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NavbarModelCopyWith<NavbarModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavbarModelCopyWith<$Res> {
  factory $NavbarModelCopyWith(
          NavbarModel value, $Res Function(NavbarModel) then) =
      _$NavbarModelCopyWithImpl<$Res, NavbarModel>;
  @useResult
  $Res call({String icon, String label, String route});
}

/// @nodoc
class _$NavbarModelCopyWithImpl<$Res, $Val extends NavbarModel>
    implements $NavbarModelCopyWith<$Res> {
  _$NavbarModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? label = null,
    Object? route = null,
  }) {
    return _then(_value.copyWith(
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NavbarModelImplCopyWith<$Res>
    implements $NavbarModelCopyWith<$Res> {
  factory _$$NavbarModelImplCopyWith(
          _$NavbarModelImpl value, $Res Function(_$NavbarModelImpl) then) =
      __$$NavbarModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String icon, String label, String route});
}

/// @nodoc
class __$$NavbarModelImplCopyWithImpl<$Res>
    extends _$NavbarModelCopyWithImpl<$Res, _$NavbarModelImpl>
    implements _$$NavbarModelImplCopyWith<$Res> {
  __$$NavbarModelImplCopyWithImpl(
      _$NavbarModelImpl _value, $Res Function(_$NavbarModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? label = null,
    Object? route = null,
  }) {
    return _then(_$NavbarModelImpl(
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NavbarModelImpl with DiagnosticableTreeMixin implements _NavbarModel {
  const _$NavbarModelImpl(
      {required this.icon, required this.label, required this.route});

  factory _$NavbarModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NavbarModelImplFromJson(json);

  @override
  final String icon;
  @override
  final String label;
  @override
  final String route;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NavbarModel(icon: $icon, label: $label, route: $route)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NavbarModel'))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('route', route));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavbarModelImpl &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.route, route) || other.route == route));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, icon, label, route);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NavbarModelImplCopyWith<_$NavbarModelImpl> get copyWith =>
      __$$NavbarModelImplCopyWithImpl<_$NavbarModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NavbarModelImplToJson(
      this,
    );
  }
}

abstract class _NavbarModel implements NavbarModel {
  const factory _NavbarModel(
      {required final String icon,
      required final String label,
      required final String route}) = _$NavbarModelImpl;

  factory _NavbarModel.fromJson(Map<String, dynamic> json) =
      _$NavbarModelImpl.fromJson;

  @override
  String get icon;
  @override
  String get label;
  @override
  String get route;
  @override
  @JsonKey(ignore: true)
  _$$NavbarModelImplCopyWith<_$NavbarModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
