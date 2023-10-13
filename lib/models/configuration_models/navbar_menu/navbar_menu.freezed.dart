// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navbar_menu.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NavbarMenu _$NavbarMenuFromJson(Map<String, dynamic> json) {
  return _NavbarMenu.fromJson(json);
}

/// @nodoc
mixin _$NavbarMenu {
  String get icon => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get route => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NavbarMenuCopyWith<NavbarMenu> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavbarMenuCopyWith<$Res> {
  factory $NavbarMenuCopyWith(
          NavbarMenu value, $Res Function(NavbarMenu) then) =
      _$NavbarMenuCopyWithImpl<$Res, NavbarMenu>;
  @useResult
  $Res call({String icon, String label, String route});
}

/// @nodoc
class _$NavbarMenuCopyWithImpl<$Res, $Val extends NavbarMenu>
    implements $NavbarMenuCopyWith<$Res> {
  _$NavbarMenuCopyWithImpl(this._value, this._then);

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
abstract class _$$NavbarMenuImplCopyWith<$Res>
    implements $NavbarMenuCopyWith<$Res> {
  factory _$$NavbarMenuImplCopyWith(
          _$NavbarMenuImpl value, $Res Function(_$NavbarMenuImpl) then) =
      __$$NavbarMenuImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String icon, String label, String route});
}

/// @nodoc
class __$$NavbarMenuImplCopyWithImpl<$Res>
    extends _$NavbarMenuCopyWithImpl<$Res, _$NavbarMenuImpl>
    implements _$$NavbarMenuImplCopyWith<$Res> {
  __$$NavbarMenuImplCopyWithImpl(
      _$NavbarMenuImpl _value, $Res Function(_$NavbarMenuImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? icon = null,
    Object? label = null,
    Object? route = null,
  }) {
    return _then(_$NavbarMenuImpl(
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
class _$NavbarMenuImpl with DiagnosticableTreeMixin implements _NavbarMenu {
  const _$NavbarMenuImpl(
      {required this.icon, required this.label, required this.route});

  factory _$NavbarMenuImpl.fromJson(Map<String, dynamic> json) =>
      _$$NavbarMenuImplFromJson(json);

  @override
  final String icon;
  @override
  final String label;
  @override
  final String route;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NavbarMenu(icon: $icon, label: $label, route: $route)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NavbarMenu'))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('route', route));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavbarMenuImpl &&
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
  _$$NavbarMenuImplCopyWith<_$NavbarMenuImpl> get copyWith =>
      __$$NavbarMenuImplCopyWithImpl<_$NavbarMenuImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NavbarMenuImplToJson(
      this,
    );
  }
}

abstract class _NavbarMenu implements NavbarMenu {
  const factory _NavbarMenu(
      {required final String icon,
      required final String label,
      required final String route}) = _$NavbarMenuImpl;

  factory _NavbarMenu.fromJson(Map<String, dynamic> json) =
      _$NavbarMenuImpl.fromJson;

  @override
  String get icon;
  @override
  String get label;
  @override
  String get route;
  @override
  @JsonKey(ignore: true)
  _$$NavbarMenuImplCopyWith<_$NavbarMenuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
