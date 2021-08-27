
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pl_calculation/core/database/base_model.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl_calculation/core/network/api_endpoint.dart';
import 'package:pl_calculation/core/network/sp_database.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/features/auth/data/models/login_model.dart';
import 'package:pl_calculation/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/login_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/resend_otp_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_otp_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_register_new_account_usecase.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_event.dart';
import 'package:pl_calculation/features/auth/presentation/widgets/input_otp_register_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<BaseModel> sendRegister(ParamsRegister paramsRegister);
  Future<LoginModel> sendLogin(ParamsLogin paramsLogin);
  Future<BaseModel> verifyAccount(ParamsOTP paramsOTP);
  Future<BaseModel> resendCode(ParamsResentOtp paramsResentOtp);
  Future<BaseModel> forgotPassword(ParamsForgotPassword paramsForgotPassword);
  Future<BaseModel> resetPassword(ParamsResetPassword paramsResetPassword);
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
        // alertToast(response.data['message']);
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
        if(response.data['message'].toString().toLowerCase().contains("not verified")){
          showDialog(
              context: paramsLogin.context!,
              builder: (_) {
                return InputOTPRegisterDialog(email: paramsLogin.email, from: "login",);
              });
        }

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
  Future<BaseModel> resendCode(ParamsResentOtp paramsResentOtp) async {
    final tag = 'VERIFY';

    final url = SEND_RESEND_CODE_API;

    try{
      final Response response = await client!.get(
          url,
          queryParameters: {
            "email" : paramsResentOtp.email,
          }
      );

      print('$tag: ${response.realUri}');
      print('$tag: $response');

      if (response.data['code'] == 200){
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
  Future<BaseModel> verifyAccount(ParamsOTP paramsOTP) async {
    final tag = 'VERIFY';

    final url = SEND_RESEND_CODE_API;

    FormData formData = FormData.fromMap({
      "email" : paramsOTP.email,
      "code" : paramsOTP.kode
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
  Future<BaseModel> forgotPassword(ParamsForgotPassword paramsForgotPassword) async {
    final tag = 'VERIFY';

    final url = FORGOT_PASSWORD_API;

    FormData formData = FormData.fromMap({
      "email" : paramsForgotPassword.email,
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
        return BaseModel.fromJson(response.data);
      } else {
        // alertToast(response.data['message']);
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
  Future<BaseModel> resetPassword(ParamsResetPassword paramsResetPassword) async {
    final tag = 'RESULT';
    final Response response;

    final token = sharedPreferences!.getString(TOKEN_CACHE);

    print('token: $token');

    final url = RESET_PASSWORD_API;

    FormData formData = FormData.fromMap({
      "old_password" : paramsResetPassword.oldPassword,
      "password" : paramsResetPassword.newPassword,
      "password_confirmation" : paramsResetPassword.newPassword
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
      print('$tag: ${response.data}');

      if (response.data['code'] == 200){
        return BaseModel.fromJson(response.data);
      } else {
        alertToast(response.data['message']);
        throw ServerException();
      }
    }on DioError catch(e){
      print('$tag: ${formData.fields}');
      // return ResultModel();
      if(e.response != null && e.response?.statusCode == 401){
        paramsResetPassword.context!.read<AuthBloc>().add(LogoutUserEvent(paramsResetPassword.context!));
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