import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pl_calculation/features/result/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/data/models/result_model.dart';
import 'package:pl_calculation/features/result/domain/repositories/result_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class GetResultUsecase extends UseCase<ResultModel, ParamsCalculation>{
  final ResultRepository resultRepository;

  GetResultUsecase(this.resultRepository);

  @override
  Future<Either<Failure, ResultModel>> call(ParamsCalculation params) async {
    return await resultRepository.getResult(params);
  }
}

class ParamsCalculation extends Equatable {
  final BuildContext? context;
  final CalculateEntity? calculateEntity;

  ParamsCalculation(
      {this.context, this.calculateEntity});

  @override
  List<Object> get props => [calculateEntity!, context!,];
}