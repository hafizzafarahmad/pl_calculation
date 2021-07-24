// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultEntityAdapter extends TypeAdapter<ResultEntity> {
  @override
  final int typeId = 2;

  @override
  ResultEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultEntity(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ResultEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.resultH27)
      ..writeByte(1)
      ..write(obj.resultH28)
      ..writeByte(2)
      ..write(obj.resultH30)
      ..writeByte(3)
      ..write(obj.resultH31)
      ..writeByte(4)
      ..write(obj.resultH32);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
