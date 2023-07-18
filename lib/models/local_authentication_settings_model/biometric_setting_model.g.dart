// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_setting_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BiometricSettingsAdapter extends TypeAdapter<BiometricSettings> {
  @override
  final int typeId = 0;

  @override
  BiometricSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BiometricSettings(
      isBiometricSecurity: fields[0] == null ? false : fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BiometricSettings obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isBiometricSecurity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BiometricSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
