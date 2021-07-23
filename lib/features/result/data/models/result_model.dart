import 'package:pl_calculation/features/result/domain/entities/result_entity.dart';

class ResultModel {
  int? code;
  String? message;
  ResultEntity? data;

  ResultModel({this.code, this.message, this.data});

  ResultModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new ResultEntity.fromJson(json['data']) : null;
  }
}