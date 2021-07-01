import 'package:dartz/dartz.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/features/calculate/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/data/models/list_notification_model.dart';

abstract class ResultRepository{
  Future<Either<Failure, ResultModel>> getResult(CalculateEntity calculateEntity);
}