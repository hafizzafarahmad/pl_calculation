import 'package:dartz/dartz.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/features/listResult/domain/entities/list_result_entity.dart';

abstract class ListResultRepository{
  Future<Either<Failure, List<ListResultEntity>>> getListResultCache();
}