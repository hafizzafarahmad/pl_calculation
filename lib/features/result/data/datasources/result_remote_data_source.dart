
import 'package:dio/dio.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:pl_calculation/core/network/api_endpoint.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/features/calculate/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/data/models/result_model.dart';

abstract class ResultRemoteDataSource{
  Future<ResultModel> getResult(CalculateEntity calculateEntity);
}

class ResultRemoteDataSourceImpl implements ResultRemoteDataSource{
  final Dio? client;

  ResultRemoteDataSourceImpl({this.client});

  @override
  Future<ResultModel> getResult(CalculateEntity calculateEntity)  async {
    final tag = 'FREE RESULT';

    final url = RESULT_API;

    print('$tag: $url');
    try{
      final Response response = await client!.get(
          url,
          queryParameters: {
            "D7" : calculateEntity.barometricPressure,
            "D8" : calculateEntity.inletDryBulbTemperature,
            "D9" : calculateEntity.inletWetBulbTemperature,
            "D10" : calculateEntity.inletRelativeHumidity,
            "D13" : calculateEntity.gTFuelFlow,
            "D14" : calculateEntity.fuelTemperature,
            "D16" : calculateEntity.injectionSteamFlow,
            "D17" : calculateEntity.temperature,
            "D18" : calculateEntity.pressure,
            "D19" : calculateEntity.phasaWaterSteam,
            "D21" : calculateEntity.comprresorExtractionAir,
            "D22" : calculateEntity.extractionAirTemperature,
            "D24" : calculateEntity.refTemperatureEnthalpy,
            "D25" : calculateEntity.exhaustOutletTemperature,
            "D28" : calculateEntity.gTPowerOutput,
            "D29" : calculateEntity.generatorLoss,
            "D30" : calculateEntity.gearboxLoss,
            "D31" : calculateEntity.fixedHeadLoss,
            "D32" : calculateEntity.variableHeatLoss,

            "H7" : calculateEntity.methane,
            "H8" : calculateEntity.ethane,
            "H9" : calculateEntity.propane,
            "H10" : calculateEntity.iButane,
            "H11" : calculateEntity.nButane,
            "H12" : calculateEntity.iPetane,
            "H13" : calculateEntity.nPetane,
            "H14" : calculateEntity.hexane,
            "H15" : calculateEntity.nitrogen,
            "H16" : calculateEntity.carboneMonoxide,
            "H17" : calculateEntity.carbonDioxide,
            "H18" : calculateEntity.water,
            "H19" : calculateEntity.hydrogenSulfide,
            "H20" : calculateEntity.hydrogen,
            "H21" : calculateEntity.helium,
            "H22" : calculateEntity.oxygen,
            "H23" : calculateEntity.argon,
          }
      );

      print('$tag: $response');

      if (response.data['code'] == 200){
        return ResultModel.fromJson(response.data);
      } else {
        alertToast(response.data['messages']);
        throw ServerException();
      }
    }on DioError catch(e){
      print('$tag: ${e.response}');
      throw ServerException();
    }
  }

}
