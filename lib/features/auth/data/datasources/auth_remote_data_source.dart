
import 'package:dio/dio.dart';
import 'package:pl_calculation/core/database/base_model.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:pl_calculation/core/network/api_endpoint.dart';
import 'package:pl_calculation/core/network/sp_database.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/features/auth/data/models/login_model.dart';
import 'package:pl_calculation/features/auth/domain/usecase/login_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_register_new_account_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<BaseModel> sendRegister(ParamsRegister paramsRegister);
  Future<LoginModel> sendLogin(ParamsLogin paramsLogin);
}



class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final Dio? client;
  final SharedPreferences? sharedPreferences;

  AuthRemoteDataSourceImpl({this.client, this.sharedPreferences});

  @override
  Future<BaseModel> sendRegister(ParamsRegister paramsRegister) async {
    final tag = 'REGISTER';

    final url = REGISTER_API;

    FormData formData = FormData.fromMap({
      "name" : paramsRegister.nama,
      "email" : paramsRegister.email,
      "password" : paramsRegister.password,
      "password_confirmation" : paramsRegister.password
    });

    try{
      final Response response = await client!.post(
          url,
          data: formData
      );

      print('$tag: ${formData.fields}');
      print('$tag: ${response.realUri}');
      print('$tag: $response');

      if (response.data['code'] == 201){
        return BaseModel.fromJson(response.data);
      } else {
        alertToast(response.data['message']);
        throw ServerException();
      }
    }on DioError catch(e){
      print('$tag: ${e.response!.realUri}');
      print('$tag: ${e.response}');
      alertToast('Connection Timeout');
      throw ServerException();
    }
  }

  @override
  Future<LoginModel> sendLogin(ParamsLogin paramsLogin) async {
    final tag = 'LOGIN';

    final url = LOGIN_API;

    FormData formData = FormData.fromMap({
      "email" : paramsLogin.email,
      "password" : paramsLogin.password,
    });

    try{
      final Response response = await client!.post(
          url,
          data: formData
      );

      print('$tag: ${formData.fields}');
      print('$tag: ${response.realUri}');
      print('$tag: $response');

      if (response.data['code'] == 200){
        LoginModel loginModel;
        loginModel = LoginModel.fromJson(response.data);

        await sharedPreferences!.setString(TOKEN_CACHE, loginModel.data!.token!);

        return loginModel;
      } else {
        alertToast(response.data['message']);
        throw ServerException();
      }
    }on DioError catch(e){
      print('$tag: ${e.response!.realUri}');
      print('$tag: ${e.response}');
      alertToast('Connection Timeout');
      throw ServerException();
    }
  }

  
}