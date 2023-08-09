// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'first_opening_of_app_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FirstOpeningOfAppModelAdapter
    extends TypeAdapter<FirstOpeningOfAppModel> {
  @override
  final int typeId = 2;

  @override
  FirstOpeningOfAppModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FirstOpeningOfAppModel(
      state: fields[0] == null ? false : fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FirstOpeningOfAppModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.state);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FirstOpeningOfAppModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
