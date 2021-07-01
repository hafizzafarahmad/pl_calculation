
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


    throw UnimplementedError();
  }


}
