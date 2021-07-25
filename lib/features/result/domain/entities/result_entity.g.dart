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
      resultH27: fields[0] as String?,
      resultH28: fields[1] as String?,
      resultH30: fields[2] as String?,
      resultH31: fields[3] as String?,
      resultH32: fields[4] as String?,
      resultF67: fields[5] as String?,
      resultF68: fields[6] as String?,
      resultF69: fields[7] as String?,
      resultF71: fields[8] as String?,
      resultF72: fields[9] as String?,
      resultF73: fields[10] as String?,
      resultH62: fields[11] as String?,
      resultH63: fields[12] as String?,
      resultH65: fields[13] as String?,
      resultH66: fields[14] as String?,
      resultJ77: fields[15] as String?,
      resultJ78: fields[16] as String?,
      resultJ79: fields[17] as String?,
      resultJ81: fields[18] as String?,
      resultJ82: fields[19] as String?,
      resultJ83: fields[20] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ResultEntity obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.resultH27)
      ..writeByte(1)
      ..write(obj.resultH28)
      ..writeByte(2)
      ..write(obj.resultH30)
      ..writeByte(3)
      ..write(obj.resultH31)
      ..writeByte(4)
      ..write(obj.resultH32)
      ..writeByte(5)
      ..write(obj.resultF67)
      ..writeByte(6)
      ..write(obj.resultF68)
      ..writeByte(7)
      ..write(obj.resultF69)
      ..writeByte(8)
      ..write(obj.resultF71)
      ..writeByte(9)
      ..write(obj.resultF72)
      ..writeByte(10)
      ..write(obj.resultF73)
      ..writeByte(11)
      ..write(obj.resultH62)
      ..writeByte(12)
      ..write(obj.resultH63)
      ..writeByte(13)
      ..write(obj.resultH65)
      ..writeByte(14)
      ..write(obj.resultH66)
      ..writeByte(15)
      ..write(obj.resultJ77)
      ..writeByte(16)
      ..write(obj.resultJ78)
      ..writeByte(17)
      ..write(obj.resultJ79)
      ..writeByte(18)
      ..write(obj.resultJ81)
      ..writeByte(19)
      ..write(obj.resultJ82)
      ..writeByte(20)
      ..write(obj.resultJ83);
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
