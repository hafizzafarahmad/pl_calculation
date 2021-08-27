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
      enthalpy: fields[36] as String?,
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
      methane: fields[19] as String?,
      ethane: fields[20] as String?,
      propane: fields[21] as String?,
      iButane: fields[22] as String?,
      nButane: fields[23] as String?,
      iPetane: fields[24] as String?,
      nPetane: fields[25] as String?,
      hexane: fields[26] as String?,
      nitrogen: fields[27] as String?,
      carboneMonoxide: fields[28] as String?,
      carbonDioxide: fields[29] as String?,
      water: fields[30] as String?,
      hydrogenSulfide: fields[31] as String?,
      hydrogen: fields[32] as String?,
      helium: fields[33] as String?,
      oxygen: fields[34] as String?,
      argon: fields[35] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CalculateEntity obj) {
    writer
      ..writeByte(37)
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
      ..write(obj.gearboxLoss)
      ..writeByte(19)
      ..write(obj.methane)
      ..writeByte(20)
      ..write(obj.ethane)
      ..writeByte(21)
      ..write(obj.propane)
      ..writeByte(22)
      ..write(obj.iButane)
      ..writeByte(23)
      ..write(obj.nButane)
      ..writeByte(24)
      ..write(obj.iPetane)
      ..writeByte(25)
      ..write(obj.nPetane)
      ..writeByte(26)
      ..write(obj.hexane)
      ..writeByte(27)
      ..write(obj.nitrogen)
      ..writeByte(28)
      ..write(obj.carboneMonoxide)
      ..writeByte(29)
      ..write(obj.carbonDioxide)
      ..writeByte(30)
      ..write(obj.water)
      ..writeByte(31)
      ..write(obj.hydrogenSulfide)
      ..writeByte(32)
      ..write(obj.hydrogen)
      ..writeByte(33)
      ..write(obj.helium)
      ..writeByte(34)
      ..write(obj.oxygen)
      ..writeByte(35)
      ..write(obj.argon)
      ..writeByte(36)
      ..write(obj.enthalpy);
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
