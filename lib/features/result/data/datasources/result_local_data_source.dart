
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:pl_calculation/features/calculate/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/data/models/result_model.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

abstract class ResultLocalDataSource{
  Future<ResultModel> getResult(CalculateEntity calculateEntity);
}

class ResultLocalDataSourceImpl implements ResultLocalDataSource{

  @override
  Future<ResultModel> getResult(CalculateEntity calculateEntity)  async {




    ///Humidity Calculation
    double vaporPressure = 0.6705;

    double partialPressure = vaporPressure * (double.parse(calculateEntity.inletRelativeHumidity!)/100);
    double fractionOfDryAir = (double.parse(calculateEntity.barometricPressure!) - partialPressure)/double.parse(calculateEntity.barometricPressure!);
    double humidityRatio = ((1/fractionOfDryAir)-1) * 18.01528/28.9651159;

    ///Moisure Air to Combuster
    double N2A2 = 0.780840; double N2A3 = N2A2 * fractionOfDryAir; double N2A4 = 28.01340; double N2A5 = N2A3 * N2A4;
    double O2A2 = 0.209476; double O2A3 = O2A2 * fractionOfDryAir; double O2A4 = 31.99880; double O2A5 = O2A3 * O2A4;
    double CO2A2 = 0.000319; double CO2A3 = CO2A2 * fractionOfDryAir; double CO2A4 = 44.00950; double CO2A5 = CO2A3 * CO2A4;
    double H2OA2 = 1; double H2OA3 = H2OA2 * fractionOfDryAir; double H2OA4 = 18.01528; double H2OA5 = H2OA3 * H2OA4;
    double ARA2 = 0.009365; double ARA3 = ARA2 * fractionOfDryAir; double ARA4 = 39.94800; double ARA5 = ARA3 * ARA4;

    ///Dry Air to Combustor
    double N2A8 = 0.78084; double N2A9 = N2A4; double N2A10 = N2A8 * N2A9;
    double O2A8 = 0.20948; double O2A9 = O2A4; double O2A10 = O2A8 * O2A9;
    double CO2A8 = 0.00032; double CO2A9 = CO2A4; double CO2A10 = CO2A8 * CO2A9;
    double H2OA8 = 1; double H2OA9 = H2OA4; double H2OA10 = H2OA8 * H2OA9;
    double ARA8 = 0.00937; double ARA9 = ARA4; double ARA10 = ARA8 * ARA9;

    ///Excess Air
    double N2A11 = 0.780840; double N2A12 = N2A11 * fractionOfDryAir; double N2A13 = 28.01340; double N2A14 = N2A12 * N2A13;
    double O2A11 = 0.209476; double O2A12 = O2A11 * fractionOfDryAir; double O2A13 = 31.99880; double O2A14 = O2A12 * O2A13;
    double CO2A11 = 0.000319; double CO2A12 = CO2A11 * fractionOfDryAir; double CO2A13 = 44.00950; double CO2A14 = CO2A12 * CO2A13;
    double H2OA11 = 1; double H2OA12 = H2OA11 * fractionOfDryAir; double H2OA13 = 18.01528; double H2OA14 = H2OA12 * H2OA13;
    double ARA11 = 0.009365; double ARA12 = ARA11 * fractionOfDryAir; double ARA13 = 39.94800; double ARA14 = ARA12 * ARA13;

    double totalA14 = N2A14 + O2A14 + CO2A14 + H2OA14 + ARA14; ///average molecular weight [ MW dry air]

    ///FUEL GAS COMBUSTION CALCULATION
    double fuelGasMassFlow = double.parse(calculateEntity.gTFuelFlow!);
    //C2 - C4
    double methaneC2 = double.parse(calculateEntity.methane!); double methaneC3 = 16.04246; double methaneC4 = methaneC2 * methaneC3;
    double ethaneC2 = double.parse(calculateEntity.methane!); double ethaneC3 = 16.04246; double ethaneC4 = ethaneC2 * ethaneC3;
    double propaneC2 = double.parse(calculateEntity.methane!); double propaneC3 = 16.04246; double propaneC4 = propaneC2 * propaneC3;
    double iButaneC2 = double.parse(calculateEntity.methane!); double iButaneC3 = 16.04246; double iButaneC4 = iButaneC2 * iButaneC3;
    double nButaneC2 = double.parse(calculateEntity.methane!); double nButaneC3 = 16.04246; double nButaneC4 = nButaneC2 * nButaneC3;
    double iPetaneC2 = double.parse(calculateEntity.methane!); double iPetaneC3 = 16.04246; double iPetaneC4 = iPetaneC2 * iPetaneC3;
    double nPetaneC2 = double.parse(calculateEntity.methane!); double nPetaneC3 = 16.04246; double nPetaneC4 = nPetaneC2 * nPetaneC3;
    double hexaneC2 = double.parse(calculateEntity.methane!); double hexaneC3 = 16.04246; double hexaneC4 = hexaneC2 * hexaneC3;
    double nitrogenC2 = double.parse(calculateEntity.methane!); double nitrogenC3 = 16.04246; double nitrogenC4 = nitrogenC2 * nitrogenC3;
    double carboneMonoxideC2 = double.parse(calculateEntity.methane!); double carboneMonoxideC3 = 16.04246; double carboneMonoxideC4 = carboneMonoxideC2 * carboneMonoxideC3;
    double carbonDioxideC2 = double.parse(calculateEntity.methane!); double carbonDioxideC3 = 16.04246; double carbonDioxideC4 = carbonDioxideC2 * carbonDioxideC3;
    double waterC2 = double.parse(calculateEntity.methane!); double waterC3 = 16.04246; double waterC4 = waterC2 * waterC3;
    double hydrogenSulfideC2 = double.parse(calculateEntity.methane!); double hydrogenSulfideC3 = 16.04246; double hydrogenSulfideC4 = hydrogenSulfideC2 * hydrogenSulfideC3;
    double hydrogenC2 = double.parse(calculateEntity.methane!); double hydrogenC3 = 16.04246; double hydrogenC4 = hydrogenC2 * hydrogenC3;
    double heliumC2 = double.parse(calculateEntity.methane!); double heliumC3 = 16.04246; double heliumC4 = heliumC2 * heliumC3;
    double oxygenC2 = double.parse(calculateEntity.methane!); double oxygenC3 = 16.04246; double oxygenC4 = oxygenC2 * oxygenC3;
    double argonC2 = double.parse(calculateEntity.methane!); double argonC3 = 16.04246; double argonC4 = argonC2 * argonC3;
    double heptaneC2 = double.parse(calculateEntity.methane!); double heptaneC3 = 16.04246; double heptaneC4 = heptaneC2 * heptaneC3;

    double averageMolarWeight = methaneC4 + ethaneC4 + propaneC4 + iButaneC4 + nButaneC4 + iPetaneC4 + nPetaneC4
    + hexaneC4 + nitrogenC4 + carboneMonoxideC4 + carbonDioxideC4 + waterC4 + hydrogenSulfideC4 + hydrogenC4
    + heliumC4 + oxygenC4 + argonC4 + heptaneC4; /// sum C4
    double fuelGasMolarFlow = fuelGasMassFlow/averageMolarWeight;





    // ByteData data = await rootBundle.load("assets/data/data_excel.xlsx");
    // var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // var excel = Excel.decodeBytes(bytes);
    // Sheet sheetObject = excel['ASME PTC 22'];
    // var cell = sheetObject.cell(CellIndex.indexByString("D156"));
    // print(cell);


    // for (var table in excel.tables.keys) {
    //   print(table); //sheet Name
    //
    //   // print(excel.tables[table]!.maxCols);
    //   // print(excel.tables[table]!.maxRows);
    //   // for (var row in excel.tables[table]!.rows) {
    //   //   print("$row");
    //   // }
    // }
    return ResultModel();
  }

}
