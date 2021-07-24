

import 'package:dartz/dartz.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/features/calculate/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/data/datasources/result_remote_data_source.dart';
import 'package:pl_calculation/features/result/data/models/result_model.dart';
import 'package:pl_calculation/features/result/domain/repositories/result_repository.dart';

class ResultRepositoryImpl implements ResultRepository{
  final ResultRemoteDataSource? resultRemoteDataSource;

  ResultRepositoryImpl(
      {this.resultRemoteDataSource});

  @override
  Future<Either<Failure, ResultModel>> getResult(CalculateEntity calculateEntity) async {
    try{
      final result = await resultRemoteDataSource!.getResultData(calculateEntity);
      return Right(result);
    }on CacheException{
      return Left(ServerFailure());
    }
  }

}