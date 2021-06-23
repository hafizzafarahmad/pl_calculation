import 'package:hive/hive.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
part 'calculate_entity.g.dart';

@HiveType(typeId: TYPE_CALCULATION)
class CalculateEntity{
  @HiveField(0)
  String? barometricPressure;
  @HiveField(1)
  String? inletDryBulbTemperature;
  @HiveField(2)
  String? inletWetBulbTemperature;
  @HiveField(3)
  String? inletRelativeHumidity;
  @HiveField(4)
  String? gTFuelFlow;
  @HiveField(5)
  String? fuelTemperature;
  @HiveField(6)
  String? injectionSteamFlow;
  @HiveField(7)
  String? temperature;
  @HiveField(8)
  String? pressure;
  @HiveField(9)
  String? phasaWaterSteam;
  @HiveField(10)
  String? comprresorExtractionAir;
  @HiveField(11)
  String? extractionAirTemperature;
  @HiveField(12)
  String? refTemperatureEnthalpy;
  @HiveField(13)
  String? exhaustOutletTemperature;
  @HiveField(14)
  String? gTPowerOutput;
  @HiveField(15)
  String? generatorLoss;
  @HiveField(16)
  String? fixedHeadLoss;
  @HiveField(17)
  String? variableHeatLoss;
  @HiveField(18)
  String? gearboxLoss;


  CalculateEntity({
    this.barometricPressure,
    this.inletDryBulbTemperature,
    this.inletWetBulbTemperature,
    this.inletRelativeHumidity,
    this.gTFuelFlow,
    this.fuelTemperature,
    this.injectionSteamFlow,
    this.temperature,
    this.pressure,
    this.phasaWaterSteam,
    this.comprresorExtractionAir,
    this.extractionAirTemperature,
    this.refTemperatureEnthalpy,
    this.exhaustOutletTemperature,
    this.gTPowerOutput,
    this.generatorLoss,
    this.fixedHeadLoss,
    this.variableHeatLoss,
    this.gearboxLoss
  });
}