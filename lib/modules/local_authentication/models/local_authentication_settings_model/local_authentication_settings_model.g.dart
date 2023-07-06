// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_authentication_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalAuthenticationSettingsAdapter
    extends TypeAdapter<LocalAuthenticationSettings> {
  @override
  final int typeId = 0;

  @override
  LocalAuthenticationSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalAuthenticationSettings(
      isLocalPassword: fields[0] == null ? false : fields[0] as bool,
      isBiometricSecurity: fields[1] == null ? false : fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LocalAuthenticationSettings obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isLocalPassword)
      ..writeByte(1)
      ..write(obj.isBiometricSecurity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalAuthenticationSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
