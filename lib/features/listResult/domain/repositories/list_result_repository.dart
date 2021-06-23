import 'package:dartz/dartz.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/features/listResult/data/models/list_pengajuan_model.dart';

abstract class ListResultRepository{
  Future<Either<Failure, ListResultModel>> getListResult();
}