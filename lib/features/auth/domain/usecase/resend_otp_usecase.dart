import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pl_calculation/core/database/base_model.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/core/usecase/usecase.dart';
import 'package:pl_calculation/features/auth/domain/repositories/auth_repository.dart';

class ResendOtpUsecase implements UseCase<BaseModel, ParamsResentOtp> {
  final AuthRepository repository;

  ResendOtpUsecase(this.repository);

  Future<Either<Failure, BaseModel>> call(ParamsResentOtp params) async {
    return await repository.resendOTP(params);
  }
}

class ParamsResentOtp extends Equatable {
  final String? email;

  ParamsResentOtp({
    @required this.email,
  });

  @override
  List<Object> get props => [email!];
}