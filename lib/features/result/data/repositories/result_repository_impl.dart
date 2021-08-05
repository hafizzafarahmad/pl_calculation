

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/features/result/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/data/datasources/result_remote_data_source.dart';
import 'package:pl_calculation/features/result/data/models/result_model.dart';
import 'package:pl_calculation/features/result/domain/repositories/result_repository.dart';
import 'package:pl_calculation/features/result/domain/usecase/get_result_usecase.dart';

class ResultRepositoryImpl implements ResultRepository{
  final ResultRemoteDataSource? resultRemoteDataSource;

  ResultRepositoryImpl(
      {this.resultRemoteDataSource});

  @override
  Future<Either<Failure, ResultModel>> getResult(ParamsCalculation paramsCalculation) async {
    try{
      final result = await resultRemoteDataSource!.getResultData(paramsCalculation);
      return Right(result);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

}