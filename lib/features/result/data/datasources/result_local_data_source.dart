
import 'package:pl_calculation/features/calculate/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/data/models/list_notification_model.dart';

abstract class ResultLocalDataSource{
  Future<ResultModel> getResult(CalculateEntity calculateEntity);
}

class ResultLocalDataSourceImpl implements ResultLocalDataSource{

  @override
  Future<ResultModel> getResult(CalculateEntity calculateEntity) {
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

    throw UnimplementedError();
  }


}
