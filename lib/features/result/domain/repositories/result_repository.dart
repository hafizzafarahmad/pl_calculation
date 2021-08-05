import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/features/result/data/models/result_model.dart';
import 'package:pl_calculation/features/result/domain/usecase/get_result_usecase.dart';

abstract class ResultRepository{
  Future<Either<Failure, ResultModel>> getResult(ParamsCalculation paramsCalculation);
}