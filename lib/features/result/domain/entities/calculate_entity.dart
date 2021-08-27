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

  @HiveField(19)
  String? methane;
  @HiveField(20)
  String? ethane;
  @HiveField(21)
  String? propane;
  @HiveField(22)
  String? iButane;
  @HiveField(23)
  String? nButane;
  @HiveField(24)
  String? iPetane;
  @HiveField(25)
  String? nPetane;
  @HiveField(26)
  String? hexane;
  @HiveField(27)
  String? nitrogen;
  @HiveField(28)
  String? carboneMonoxide;
  @HiveField(29)
  String? carbonDioxide;
  @HiveField(30)
  String? water;
  @HiveField(31)
  String? hydrogenSulfide;
  @HiveField(32)
  String? hydrogen;
  @HiveField(33)
  String? helium;
  @HiveField(34)
  String? oxygen;
  @HiveField(35)
  String? argon;
  @HiveField(36)
  String? enthalpy;


  CalculateEntity({
    this.enthalpy,
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
    this.gearboxLoss,

    this.methane,
    this.ethane,
    this.propane,
    this.iButane,
    this.nButane,
    this.iPetane,
    this.nPetane,
    this.hexane,
    this.nitrogen,
    this.carboneMonoxide,
    this.carbonDioxide,
    this.water,
    this.hydrogenSulfide,
    this.hydrogen,
    this.helium,
    this.oxygen,
    this.argon,
  });
}