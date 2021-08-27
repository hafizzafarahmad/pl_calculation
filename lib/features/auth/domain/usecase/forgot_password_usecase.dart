import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pl_calculation/core/database/base_model.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/core/usecase/usecase.dart';
import 'package:pl_calculation/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUsecase implements UseCase<BaseModel, ParamsForgotPassword> {
  final AuthRepository repository;

  ForgotPasswordUsecase(this.repository);

  Future<Either<Failure, BaseModel>> call(ParamsForgotPassword params) async {
    return await repository.forgotPassword(params);
  }
}

class ParamsForgotPassword extends Equatable {
  final String? email;

  ParamsForgotPassword({
    @required this.email,
  });

  @override
  List<Object> get props => [email!];
}