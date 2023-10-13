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
  String get role => throw _privateConstructorUsedError;
  List<NavbarMenu> get menu => throw _privateConstructorUsedError;

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
  $Res call({String role, List<NavbarMenu> menu});
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
    Object? role = null,
    Object? menu = null,
  }) {
    return _then(_value.copyWith(
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      menu: null == menu
          ? _value.menu
          : menu // ignore: cast_nullable_to_non_nullable
              as List<NavbarMenu>,
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
  $Res call({String role, List<NavbarMenu> menu});
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
    Object? role = null,
    Object? menu = null,
  }) {
    return _then(_$NavbarModelImpl(
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      menu: null == menu
          ? _value._menu
          : menu // ignore: cast_nullable_to_non_nullable
              as List<NavbarMenu>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NavbarModelImpl with DiagnosticableTreeMixin implements _NavbarModel {
  const _$NavbarModelImpl(
      {required this.role, required final List<NavbarMenu> menu})
      : _menu = menu;

  factory _$NavbarModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NavbarModelImplFromJson(json);

  @override
  final String role;
  final List<NavbarMenu> _menu;
  @override
  List<NavbarMenu> get menu {
    if (_menu is EqualUnmodifiableListView) return _menu;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_menu);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NavbarModel(role: $role, menu: $menu)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NavbarModel'))
      ..add(DiagnosticsProperty('role', role))
      ..add(DiagnosticsProperty('menu', menu));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavbarModelImpl &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(other._menu, _menu));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, role, const DeepCollectionEquality().hash(_menu));

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
      {required final String role,
      required final List<NavbarMenu> menu}) = _$NavbarModelImpl;

  factory _NavbarModel.fromJson(Map<String, dynamic> json) =
      _$NavbarModelImpl.fromJson;

  @override
  String get role;
  @override
  List<NavbarMenu> get menu;
  @override
  @JsonKey(ignore: true)
  _$$NavbarModelImplCopyWith<_$NavbarModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
