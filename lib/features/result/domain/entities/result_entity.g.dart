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
      h28: fields[0] as String?,
      h67: fields[34] as String?,
      h29: fields[1] as String?,
      j80: fields[33] as String?,
      h31: fields[2] as String?,
      h32: fields[3] as String?,
      h33: fields[4] as String?,
      h62: fields[5] as String?,
      h63: fields[6] as String?,
      h64: fields[7] as String?,
      h66: fields[8] as String?,
      f67: fields[9] as String?,
      f68: fields[10] as String?,
      f69: fields[11] as String?,
      f72: fields[12] as String?,
      f73: fields[13] as String?,
      f74: fields[14] as String?,
      j31: fields[15] as String?,
      j32: fields[16] as String?,
      j33: fields[17] as String?,
      j71: fields[18] as String?,
      j72: fields[19] as String?,
      j73: fields[20] as String?,
      j74: fields[21] as String?,
      j75: fields[22] as String?,
      j76: fields[23] as String?,
      j77: fields[24] as String?,
      j78: fields[25] as String?,
      j79: fields[26] as String?,
      j82: fields[27] as String?,
      j83: fields[28] as String?,
      j84: fields[29] as String?,
      d82: fields[30] as String?,
      d83: fields[31] as String?,
      d84: fields[32] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ResultEntity obj) {
    writer
      ..writeByte(35)
      ..writeByte(0)
      ..write(obj.h28)
      ..writeByte(1)
      ..write(obj.h29)
      ..writeByte(2)
      ..write(obj.h31)
      ..writeByte(3)
      ..write(obj.h32)
      ..writeByte(4)
      ..write(obj.h33)
      ..writeByte(5)
      ..write(obj.h62)
      ..writeByte(6)
      ..write(obj.h63)
      ..writeByte(7)
      ..write(obj.h64)
      ..writeByte(8)
      ..write(obj.h66)
      ..writeByte(9)
      ..write(obj.f67)
      ..writeByte(10)
      ..write(obj.f68)
      ..writeByte(11)
      ..write(obj.f69)
      ..writeByte(12)
      ..write(obj.f72)
      ..writeByte(13)
      ..write(obj.f73)
      ..writeByte(14)
      ..write(obj.f74)
      ..writeByte(15)
      ..write(obj.j31)
      ..writeByte(16)
      ..write(obj.j32)
      ..writeByte(17)
      ..write(obj.j33)
      ..writeByte(18)
      ..write(obj.j71)
      ..writeByte(19)
      ..write(obj.j72)
      ..writeByte(20)
      ..write(obj.j73)
      ..writeByte(21)
      ..write(obj.j74)
      ..writeByte(22)
      ..write(obj.j75)
      ..writeByte(23)
      ..write(obj.j76)
      ..writeByte(24)
      ..write(obj.j77)
      ..writeByte(25)
      ..write(obj.j78)
      ..writeByte(26)
      ..write(obj.j79)
      ..writeByte(27)
      ..write(obj.j82)
      ..writeByte(28)
      ..write(obj.j83)
      ..writeByte(29)
      ..write(obj.j84)
      ..writeByte(30)
      ..write(obj.d82)
      ..writeByte(31)
      ..write(obj.d83)
      ..writeByte(32)
      ..write(obj.d84)
      ..writeByte(33)
      ..write(obj.j80)
      ..writeByte(34)
      ..write(obj.h67);
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
