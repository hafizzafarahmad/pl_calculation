import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pl_calculation/core/platform/component.dart';

import 'exception.dart';

void errorHandler(BuildContext context, DioError e){
  if(e.response != null && e.response?.statusCode == 401){
    Navigator.pop(context);
    alertToast('Opps, Token Expire');
    throw ServerException();
  }else{
    alertToast('Opps, Terjadi kesalahan');
    throw ServerException();
  }
}