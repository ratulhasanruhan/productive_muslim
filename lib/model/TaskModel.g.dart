// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TaskModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelTaskAdapter extends TypeAdapter<ModelTask> {
  @override
  final int typeId = 1;

  @override
  ModelTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelTask(
      title: fields[0] as String,
      checked: fields[1] == null ? false : fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ModelTask obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.checked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
