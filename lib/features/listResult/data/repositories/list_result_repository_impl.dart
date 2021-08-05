

import 'package:dartz/dartz.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/features/listResult/data/datasources/list_result_local_data_source.dart';
import 'package:pl_calculation/features/listResult/domain/entities/list_result_entity.dart';
import 'package:pl_calculation/features/listResult/domain/repositories/list_result_repository.dart';

class ListResultRepositoryImpl implements ListResultRepository{
  final ListResultLocalDataSource? listResultLocalDataSource;

  ListResultRepositoryImpl(
      {this.listResultLocalDataSource});

  @override
  Future<Either<Failure, List<ListResultEntity>>> getListResultCache() async {
    try{
      final result = await listResultLocalDataSource!.getCacheListResult();
      return Right(result);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

}