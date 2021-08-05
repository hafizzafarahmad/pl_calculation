
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pl_calculation/core/error/error_handler.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:pl_calculation/core/network/api_endpoint.dart';
import 'package:pl_calculation/core/network/sp_database.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/features/result/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/data/models/result_model.dart';
import 'package:pl_calculation/features/result/domain/usecase/get_result_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ResultRemoteDataSource{
  Future<ResultModel> getResultData(ParamsCalculation paramsCalculation);
}

class ResultRemoteDataSourceImpl implements ResultRemoteDataSource{
  final Dio? client;
  final SharedPreferences? sharedPreferences;

  ResultRemoteDataSourceImpl( {this.client, this.sharedPreferences,});

  @override
  Future<ResultModel> getResultData(ParamsCalculation paramsCalculation)  async {
    final tag = 'RESULT';
    final Response response;

    final token = sharedPreferences!.getString(TOKEN_CACHE);

    print('token: $token');

    final url = RESULT_API;

    FormData formData = FormData.fromMap({
      "input[D7]" : double.parse(paramsCalculation.calculateEntity!.barometricPressure!.replaceAll(",", "")),
      "input[D8]" : double.parse(paramsCalculation.calculateEntity!.inletDryBulbTemperature!.replaceAll(",", "")),
      "input[D9]" : double.parse(paramsCalculation.calculateEntity!.inletWetBulbTemperature!.replaceAll(",", "")),
      "input[D10]" : double.parse(paramsCalculation.calculateEntity!.inletRelativeHumidity!.replaceAll(",", "")),
      "input[D13]" : double.parse(paramsCalculation.calculateEntity!.gTFuelFlow!.replaceAll(",", "")),
      "input[D14]" : double.parse(paramsCalculation.calculateEntity!.fuelTemperature!.replaceAll(",", "")),
      "input[D16]" : double.parse(paramsCalculation.calculateEntity!.injectionSteamFlow!.replaceAll(",", "")),
      "input[D17]" : double.parse(paramsCalculation.calculateEntity!.temperature!.replaceAll(",", "")),
      "input[D18]" : double.parse(paramsCalculation.calculateEntity!.pressure!.replaceAll(",", "")),
      "input[D19]" : double.parse(paramsCalculation.calculateEntity!.phasaWaterSteam!.replaceAll(",", "")),
      "input[D21]" : double.parse(paramsCalculation.calculateEntity!.comprresorExtractionAir!.replaceAll(",", "")),
      "input[D22]" : double.parse(paramsCalculation.calculateEntity!.extractionAirTemperature!.replaceAll(",", "")),
      "input[D24]" : double.parse(paramsCalculation.calculateEntity!.refTemperatureEnthalpy!.replaceAll(",", "")),
      "input[D25]" : double.parse(paramsCalculation.calculateEntity!.exhaustOutletTemperature!.replaceAll(",", "")),
      "input[D28]" : double.parse(paramsCalculation.calculateEntity!.gTPowerOutput!.replaceAll(",", "")),
      "input[D29]" : double.parse(paramsCalculation.calculateEntity!.generatorLoss!.replaceAll(",", "")),
      "input[D30]" : double.parse(paramsCalculation.calculateEntity!.gearboxLoss!.replaceAll(",", "")),
      "input[D31]" : double.parse(paramsCalculation.calculateEntity!.fixedHeadLoss!.replaceAll(",", "")),
      "input[D32]" : double.parse(paramsCalculation.calculateEntity!.variableHeatLoss!.replaceAll(",", "")),
      "input[H7]" : double.parse(paramsCalculation.calculateEntity!.methane!.replaceAll(",", "")),
      "input[H8]" : double.parse(paramsCalculation.calculateEntity!.ethane!.replaceAll(",", "")),
      "input[H9]" : double.parse(paramsCalculation.calculateEntity!.propane!.replaceAll(",", "")),
      "input[H10]" : double.parse(paramsCalculation.calculateEntity!.iButane!.replaceAll(",", "")),
      "input[H11]" : double.parse(paramsCalculation.calculateEntity!.nButane!.replaceAll(",", "")),
      "input[H12]" : double.parse(paramsCalculation.calculateEntity!.iPetane!.replaceAll(",", "")),
      "input[H13]" : double.parse(paramsCalculation.calculateEntity!.nPetane!.replaceAll(",", "")),
      "input[H14]" : double.parse(paramsCalculation.calculateEntity!.hexane!.replaceAll(",", "")),
      "input[H15]" : double.parse(paramsCalculation.calculateEntity!.nitrogen!.replaceAll(",", "")),
      "input[H16]" : double.parse(paramsCalculation.calculateEntity!.carboneMonoxide!.replaceAll(",", "")),
      "input[H17]" : double.parse(paramsCalculation.calculateEntity!.carbonDioxide!.replaceAll(",", "")),
      "input[H18]" : double.parse(paramsCalculation.calculateEntity!.water!.replaceAll(",", "")),
      "input[H20]" : double.parse(paramsCalculation.calculateEntity!.hydrogen!.replaceAll(",", "")),
      "input[H21]" : double.parse(paramsCalculation.calculateEntity!.helium!.replaceAll(",", "")),
      "input[H22]" : double.parse(paramsCalculation.calculateEntity!.oxygen!.replaceAll(",", "")),
      "input[H23]" : double.parse(paramsCalculation.calculateEntity!.argon!.replaceAll(",", "")),
    });

    print('$tag: $url');
    try{
      response = await client!.post(
          url,
          options: Options(
              headers: {'Authorization' : 'Bearer $token'}
          ),
          data: formData
      );
      print('$tag: ${formData.fields}');
      print('$tag: ${response.realUri}');

      if (response.data['code'] == 200){
        return ResultModel.fromJson(response.data);
      } else {
        alertToast(response.data['messages']);
        throw ServerException();
      }
    }on DioError catch(e){
      print('$tag: ${formData.fields}');
      // return ResultModel();
      if(e.response != null && e.response?.statusCode == 401){
        Navigator.pop(paramsCalculation.context!);
        alertToast('Token Expire');
        throw ServerException();
      }else{
        alertToast('Something Wrong');
        throw ServerException();
      }
      // print('$tag: ${e.response}');
      // print('$tag: ${e.response!.realUri}');

    }
  }

}
