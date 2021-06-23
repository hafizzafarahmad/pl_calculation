// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculate_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalculateEntityAdapter extends TypeAdapter<CalculateEntity> {
  @override
  final int typeId = 1;

  @override
  CalculateEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculateEntity(
      barometricPressure: fields[0] as String?,
      inletDryBulbTemperature: fields[1] as String?,
      inletWetBulbTemperature: fields[2] as String?,
      inletRelativeHumidity: fields[3] as String?,
      gTFuelFlow: fields[4] as String?,
      fuelTemperature: fields[5] as String?,
      injectionSteamFlow: fields[6] as String?,
      temperature: fields[7] as String?,
      pressure: fields[8] as String?,
      phasaWaterSteam: fields[9] as String?,
      comprresorExtractionAir: fields[10] as String?,
      extractionAirTemperature: fields[11] as String?,
      refTemperatureEnthalpy: fields[12] as String?,
      exhaustOutletTemperature: fields[13] as String?,
      gTPowerOutput: fields[14] as String?,
      generatorLoss: fields[15] as String?,
      fixedHeadLoss: fields[16] as String?,
      variableHeatLoss: fields[17] as String?,
      gearboxLoss: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CalculateEntity obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.barometricPressure)
      ..writeByte(1)
      ..write(obj.inletDryBulbTemperature)
      ..writeByte(2)
      ..write(obj.inletWetBulbTemperature)
      ..writeByte(3)
      ..write(obj.inletRelativeHumidity)
      ..writeByte(4)
      ..write(obj.gTFuelFlow)
      ..writeByte(5)
      ..write(obj.fuelTemperature)
      ..writeByte(6)
      ..write(obj.injectionSteamFlow)
      ..writeByte(7)
      ..write(obj.temperature)
      ..writeByte(8)
      ..write(obj.pressure)
      ..writeByte(9)
      ..write(obj.phasaWaterSteam)
      ..writeByte(10)
      ..write(obj.comprresorExtractionAir)
      ..writeByte(11)
      ..write(obj.extractionAirTemperature)
      ..writeByte(12)
      ..write(obj.refTemperatureEnthalpy)
      ..writeByte(13)
      ..write(obj.exhaustOutletTemperature)
      ..writeByte(14)
      ..write(obj.gTPowerOutput)
      ..writeByte(15)
      ..write(obj.generatorLoss)
      ..writeByte(16)
      ..write(obj.fixedHeadLoss)
      ..writeByte(17)
      ..write(obj.variableHeatLoss)
      ..writeByte(18)
      ..write(obj.gearboxLoss);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculateEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
