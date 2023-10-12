// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'configuration_of_app.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConfigurationOfApp _$ConfigurationOfAppFromJson(Map<String, dynamic> json) {
  return _ConfigurationOfApp.fromJson(json);
}

/// @nodoc
mixin _$ConfigurationOfApp {
  String get BASE_URL => throw _privateConstructorUsedError;
  String get ITUNES_URL_FOR_REQUEST => throw _privateConstructorUsedError;
  List<String> get ALLOWED_EXTERNAL_URLS => throw _privateConstructorUsedError;
  List<IntentBrowsableUris> get INTENT_BROWSABLE_URIS =>
      throw _privateConstructorUsedError;
  List<NavbarModel> get NAVBAR => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigurationOfAppCopyWith<ConfigurationOfApp> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigurationOfAppCopyWith<$Res> {
  factory $ConfigurationOfAppCopyWith(
          ConfigurationOfApp value, $Res Function(ConfigurationOfApp) then) =
      _$ConfigurationOfAppCopyWithImpl<$Res, ConfigurationOfApp>;
  @useResult
  $Res call(
      {String BASE_URL,
      String ITUNES_URL_FOR_REQUEST,
      List<String> ALLOWED_EXTERNAL_URLS,
      List<IntentBrowsableUris> INTENT_BROWSABLE_URIS,
      List<NavbarModel> NAVBAR});
}

/// @nodoc
class _$ConfigurationOfAppCopyWithImpl<$Res, $Val extends ConfigurationOfApp>
    implements $ConfigurationOfAppCopyWith<$Res> {
  _$ConfigurationOfAppCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? BASE_URL = null,
    Object? ITUNES_URL_FOR_REQUEST = null,
    Object? ALLOWED_EXTERNAL_URLS = null,
    Object? INTENT_BROWSABLE_URIS = null,
    Object? NAVBAR = null,
  }) {
    return _then(_value.copyWith(
      BASE_URL: null == BASE_URL
          ? _value.BASE_URL
          : BASE_URL // ignore: cast_nullable_to_non_nullable
              as String,
      ITUNES_URL_FOR_REQUEST: null == ITUNES_URL_FOR_REQUEST
          ? _value.ITUNES_URL_FOR_REQUEST
          : ITUNES_URL_FOR_REQUEST // ignore: cast_nullable_to_non_nullable
              as String,
      ALLOWED_EXTERNAL_URLS: null == ALLOWED_EXTERNAL_URLS
          ? _value.ALLOWED_EXTERNAL_URLS
          : ALLOWED_EXTERNAL_URLS // ignore: cast_nullable_to_non_nullable
              as List<String>,
      INTENT_BROWSABLE_URIS: null == INTENT_BROWSABLE_URIS
          ? _value.INTENT_BROWSABLE_URIS
          : INTENT_BROWSABLE_URIS // ignore: cast_nullable_to_non_nullable
              as List<IntentBrowsableUris>,
      NAVBAR: null == NAVBAR
          ? _value.NAVBAR
          : NAVBAR // ignore: cast_nullable_to_non_nullable
              as List<NavbarModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigurationOfAppImplCopyWith<$Res>
    implements $ConfigurationOfAppCopyWith<$Res> {
  factory _$$ConfigurationOfAppImplCopyWith(_$ConfigurationOfAppImpl value,
          $Res Function(_$ConfigurationOfAppImpl) then) =
      __$$ConfigurationOfAppImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String BASE_URL,
      String ITUNES_URL_FOR_REQUEST,
      List<String> ALLOWED_EXTERNAL_URLS,
      List<IntentBrowsableUris> INTENT_BROWSABLE_URIS,
      List<NavbarModel> NAVBAR});
}

/// @nodoc
class __$$ConfigurationOfAppImplCopyWithImpl<$Res>
    extends _$ConfigurationOfAppCopyWithImpl<$Res, _$ConfigurationOfAppImpl>
    implements _$$ConfigurationOfAppImplCopyWith<$Res> {
  __$$ConfigurationOfAppImplCopyWithImpl(_$ConfigurationOfAppImpl _value,
      $Res Function(_$ConfigurationOfAppImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? BASE_URL = null,
    Object? ITUNES_URL_FOR_REQUEST = null,
    Object? ALLOWED_EXTERNAL_URLS = null,
    Object? INTENT_BROWSABLE_URIS = null,
    Object? NAVBAR = null,
  }) {
    return _then(_$ConfigurationOfAppImpl(
      BASE_URL: null == BASE_URL
          ? _value.BASE_URL
          : BASE_URL // ignore: cast_nullable_to_non_nullable
              as String,
      ITUNES_URL_FOR_REQUEST: null == ITUNES_URL_FOR_REQUEST
          ? _value.ITUNES_URL_FOR_REQUEST
          : ITUNES_URL_FOR_REQUEST // ignore: cast_nullable_to_non_nullable
              as String,
      ALLOWED_EXTERNAL_URLS: null == ALLOWED_EXTERNAL_URLS
          ? _value._ALLOWED_EXTERNAL_URLS
          : ALLOWED_EXTERNAL_URLS // ignore: cast_nullable_to_non_nullable
              as List<String>,
      INTENT_BROWSABLE_URIS: null == INTENT_BROWSABLE_URIS
          ? _value._INTENT_BROWSABLE_URIS
          : INTENT_BROWSABLE_URIS // ignore: cast_nullable_to_non_nullable
              as List<IntentBrowsableUris>,
      NAVBAR: null == NAVBAR
          ? _value._NAVBAR
          : NAVBAR // ignore: cast_nullable_to_non_nullable
              as List<NavbarModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigurationOfAppImpl
    with DiagnosticableTreeMixin
    implements _ConfigurationOfApp {
  const _$ConfigurationOfAppImpl(
      {required this.BASE_URL,
      required this.ITUNES_URL_FOR_REQUEST,
      required final List<String> ALLOWED_EXTERNAL_URLS,
      required final List<IntentBrowsableUris> INTENT_BROWSABLE_URIS,
      required final List<NavbarModel> NAVBAR})
      : _ALLOWED_EXTERNAL_URLS = ALLOWED_EXTERNAL_URLS,
        _INTENT_BROWSABLE_URIS = INTENT_BROWSABLE_URIS,
        _NAVBAR = NAVBAR;

  factory _$ConfigurationOfAppImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigurationOfAppImplFromJson(json);

  @override
  final String BASE_URL;
  @override
  final String ITUNES_URL_FOR_REQUEST;
  final List<String> _ALLOWED_EXTERNAL_URLS;
  @override
  List<String> get ALLOWED_EXTERNAL_URLS {
    if (_ALLOWED_EXTERNAL_URLS is EqualUnmodifiableListView)
      return _ALLOWED_EXTERNAL_URLS;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ALLOWED_EXTERNAL_URLS);
  }

  final List<IntentBrowsableUris> _INTENT_BROWSABLE_URIS;
  @override
  List<IntentBrowsableUris> get INTENT_BROWSABLE_URIS {
    if (_INTENT_BROWSABLE_URIS is EqualUnmodifiableListView)
      return _INTENT_BROWSABLE_URIS;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_INTENT_BROWSABLE_URIS);
  }

  final List<NavbarModel> _NAVBAR;
  @override
  List<NavbarModel> get NAVBAR {
    if (_NAVBAR is EqualUnmodifiableListView) return _NAVBAR;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_NAVBAR);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConfigurationOfApp(BASE_URL: $BASE_URL, ITUNES_URL_FOR_REQUEST: $ITUNES_URL_FOR_REQUEST, ALLOWED_EXTERNAL_URLS: $ALLOWED_EXTERNAL_URLS, INTENT_BROWSABLE_URIS: $INTENT_BROWSABLE_URIS, NAVBAR: $NAVBAR)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConfigurationOfApp'))
      ..add(DiagnosticsProperty('BASE_URL', BASE_URL))
      ..add(
          DiagnosticsProperty('ITUNES_URL_FOR_REQUEST', ITUNES_URL_FOR_REQUEST))
      ..add(DiagnosticsProperty('ALLOWED_EXTERNAL_URLS', ALLOWED_EXTERNAL_URLS))
      ..add(DiagnosticsProperty('INTENT_BROWSABLE_URIS', INTENT_BROWSABLE_URIS))
      ..add(DiagnosticsProperty('NAVBAR', NAVBAR));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigurationOfAppImpl &&
            (identical(other.BASE_URL, BASE_URL) ||
                other.BASE_URL == BASE_URL) &&
            (identical(other.ITUNES_URL_FOR_REQUEST, ITUNES_URL_FOR_REQUEST) ||
                other.ITUNES_URL_FOR_REQUEST == ITUNES_URL_FOR_REQUEST) &&
            const DeepCollectionEquality()
                .equals(other._ALLOWED_EXTERNAL_URLS, _ALLOWED_EXTERNAL_URLS) &&
            const DeepCollectionEquality()
                .equals(other._INTENT_BROWSABLE_URIS, _INTENT_BROWSABLE_URIS) &&
            const DeepCollectionEquality().equals(other._NAVBAR, _NAVBAR));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      BASE_URL,
      ITUNES_URL_FOR_REQUEST,
      const DeepCollectionEquality().hash(_ALLOWED_EXTERNAL_URLS),
      const DeepCollectionEquality().hash(_INTENT_BROWSABLE_URIS),
      const DeepCollectionEquality().hash(_NAVBAR));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigurationOfAppImplCopyWith<_$ConfigurationOfAppImpl> get copyWith =>
      __$$ConfigurationOfAppImplCopyWithImpl<_$ConfigurationOfAppImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigurationOfAppImplToJson(
      this,
    );
  }
}

abstract class _ConfigurationOfApp implements ConfigurationOfApp {
  const factory _ConfigurationOfApp(
      {required final String BASE_URL,
      required final String ITUNES_URL_FOR_REQUEST,
      required final List<String> ALLOWED_EXTERNAL_URLS,
      required final List<IntentBrowsableUris> INTENT_BROWSABLE_URIS,
      required final List<NavbarModel> NAVBAR}) = _$ConfigurationOfAppImpl;

  factory _ConfigurationOfApp.fromJson(Map<String, dynamic> json) =
      _$ConfigurationOfAppImpl.fromJson;

  @override
  String get BASE_URL;
  @override
  String get ITUNES_URL_FOR_REQUEST;
  @override
  List<String> get ALLOWED_EXTERNAL_URLS;
  @override
  List<IntentBrowsableUris> get INTENT_BROWSABLE_URIS;
  @override
  List<NavbarModel> get NAVBAR;
  @override
  @JsonKey(ignore: true)
  _$$ConfigurationOfAppImplCopyWith<_$ConfigurationOfAppImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
