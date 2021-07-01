

import 'package:dartz/dartz.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/features/calculate/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/data/datasources/result_local_data_source.dart';
import 'package:pl_calculation/features/result/data/models/list_notification_model.dart';
import 'package:pl_calculation/features/result/domain/repositories/result_repository.dart';

class ResultRepositoryImpl implements ResultRepository{
  final ResultLocalDataSource? resultLocalDataSource;

  ResultRepositoryImpl(
      {this.resultLocalDataSource});

  @override
  Future<Either<Failure, ResultModel>> getResult(CalculateEntity calculateEntity) async {
    try{
      final result = await resultLocalDataSource!.getResult(calculateEntity);
      return Right(result);
    }on CacheException{
      return Left(ServerFailure());
    }
  }

}