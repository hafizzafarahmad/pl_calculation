

import 'package:dartz/dartz.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/features/listResult/data/datasources/list_result_remote_data_source.dart';
import 'package:pl_calculation/features/listResult/data/models/list_pengajuan_model.dart';
import 'package:pl_calculation/features/listResult/domain/repositories/list_result_repository.dart';

class ListResultRepositoryImpl implements ListResultRepository{
  final ListResultRemoteDataSource? listResultRemoteDataSource;

  ListResultRepositoryImpl(
      {this.listResultRemoteDataSource});

  @override
  Future<Either<Failure, ListResultModel>> getListResult() async {
    try{
      final remoteListResult = await listResultRemoteDataSource!.getListResult();
      return Right(remoteListResult);
    }on CacheException{
      return Left(ServerFailure());
    }
  }

}