// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_password_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalPasswordAdapter extends TypeAdapter<LocalPassword> {
  @override
  final int typeId = 1;

  @override
  LocalPassword read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalPassword(
      hash: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalPassword obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.hash);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalPasswordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
