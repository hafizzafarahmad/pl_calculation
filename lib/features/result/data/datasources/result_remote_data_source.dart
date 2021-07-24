
import 'package:dio/dio.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:pl_calculation/core/network/api_endpoint.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/features/calculate/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/data/models/result_model.dart';

abstract class ResultRemoteDataSource{
  Future<ResultModel> getResultData(CalculateEntity calculateEntity);
}

class ResultRemoteDataSourceImpl implements ResultRemoteDataSource{
  final Dio? client;

  ResultRemoteDataSourceImpl({this.client});

  @override
  Future<ResultModel> getResultData(CalculateEntity calculateEntity)  async {
    final tag = 'FREE RESULT';
    final Response response;

    final url = RESULT_API;
    print(double.parse(calculateEntity.exhaustOutletTemperature!.replaceAll(",", "")));

    print('$tag: $url');
    try{
      response = await client!.get(
          url,
          queryParameters: {
            "D7" : double.parse(calculateEntity.barometricPressure!.replaceAll(",", "")),
            "D8" : double.parse(calculateEntity.inletDryBulbTemperature!.replaceAll(",", "")),
            "D9" : double.parse(calculateEntity.inletWetBulbTemperature!.replaceAll(",", "")),
            "D10" : double.parse(calculateEntity.inletRelativeHumidity!.replaceAll(",", "")),
            "D13" : double.parse(calculateEntity.gTFuelFlow!.replaceAll(",", "")),
            "D14" : double.parse(calculateEntity.fuelTemperature!.replaceAll(",", "")),
            "D16" : double.parse(calculateEntity.injectionSteamFlow!.replaceAll(",", "")),
            "D17" : double.parse(calculateEntity.temperature!.replaceAll(",", "")),
            "D18" : double.parse(calculateEntity.pressure!.replaceAll(",", "")),
            "D19" : double.parse(calculateEntity.phasaWaterSteam!.replaceAll(",", "")),
            "D21" : double.parse(calculateEntity.comprresorExtractionAir!.replaceAll(",", "")),
            "D22" : double.parse(calculateEntity.extractionAirTemperature!.replaceAll(",", "")),
            "D24" : double.parse(calculateEntity.refTemperatureEnthalpy!.replaceAll(",", "")),
            "D25" : double.parse(calculateEntity.exhaustOutletTemperature!.replaceAll(",", "")),
            "D28" : double.parse(calculateEntity.gTPowerOutput!.replaceAll(",", "")),
            "D29" : double.parse(calculateEntity.generatorLoss!.replaceAll(",", "")),
            "D30" : double.parse(calculateEntity.gearboxLoss!.replaceAll(",", "")),
            "D31" : double.parse(calculateEntity.fixedHeadLoss!.replaceAll(",", "")),
            "D32" : double.parse(calculateEntity.variableHeatLoss!.replaceAll(",", "")),
            "H7" : double.parse(calculateEntity.methane!.replaceAll(",", "")),
            "H8" : double.parse(calculateEntity.ethane!.replaceAll(",", "")),
            "H9" : double.parse(calculateEntity.propane!.replaceAll(",", "")),
            "H10" : double.parse(calculateEntity.iButane!.replaceAll(",", "")),
            "H11" : double.parse(calculateEntity.nButane!.replaceAll(",", "")),
            "H12" : double.parse(calculateEntity.iPetane!.replaceAll(",", "")),
            "H13" : double.parse(calculateEntity.nPetane!.replaceAll(",", "")),
            "H14" : double.parse(calculateEntity.hexane!.replaceAll(",", "")),
            "H15" : double.parse(calculateEntity.nitrogen!.replaceAll(",", "")),
            "H16" : double.parse(calculateEntity.carboneMonoxide!.replaceAll(",", "")),
            "H17" : double.parse(calculateEntity.carbonDioxide!.replaceAll(",", "")),
            "H18" : double.parse(calculateEntity.water!.replaceAll(",", "")),
            "H20" : double.parse(calculateEntity.hydrogen!.replaceAll(",", "")),
            "H21" : double.parse(calculateEntity.helium!.replaceAll(",", "")),
            "H22" : double.parse(calculateEntity.oxygen!.replaceAll(",", "")),
            "H23" : double.parse(calculateEntity.argon!.replaceAll(",", "")),
          }
      );
      print('$tag: $response');
      print('$tag: ${response.realUri}');

      if (response.data['code'] == 200){
        return ResultModel.fromJson(response.data);
      } else {
        alertToast(response.data['messages']);
        throw ServerException();
      }
    }on DioError catch(e){
      // return ResultModel();
      throw ServerException();
      // print('$tag: ${e.response}');
      // print('$tag: ${e.response!.realUri}');

    }
  }

}
