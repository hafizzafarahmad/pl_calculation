// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_result_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListResultEntityAdapter extends TypeAdapter<ListResultEntity> {
  @override
  final int typeId = 0;

  @override
  ListResultEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListResultEntity(
      fields[0] as ResultEntity?,
      fields[1] as CalculateEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, ListResultEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.resultEntity)
      ..writeByte(1)
      ..write(obj.calculateEntity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListResultEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
