import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pl_calculation/core/database/base_model.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/core/usecase/usecase.dart';
import 'package:pl_calculation/features/auth/domain/repositories/auth_repository.dart';

class SendOTPUsecase implements UseCase<BaseModel, ParamsOTP> {
  final AuthRepository repository;

  SendOTPUsecase(this.repository);

  Future<Either<Failure, BaseModel>> call(ParamsOTP params) async {
    return await repository.sendOTP(params);
  }
}

class ParamsOTP extends Equatable {
  final String? kode;
  final String? email;

  ParamsOTP({@required this.kode, @required this.email});

  @override
  List<Object> get props => [kode!, email!];
}