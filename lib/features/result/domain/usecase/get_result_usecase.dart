import 'package:dartz/dartz.dart';
import 'package:pl_calculation/features/calculate/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/data/models/result_model.dart';
import 'package:pl_calculation/features/result/domain/repositories/result_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class GetResultUsecase extends UseCase<ResultModel, CalculateEntity>{
  final ResultRepository resultRepository;

  GetResultUsecase(this.resultRepository);

  @override
  Future<Either<Failure, ResultModel>> call(CalculateEntity params) async {
    return await resultRepository.getResult(params);
  }
}