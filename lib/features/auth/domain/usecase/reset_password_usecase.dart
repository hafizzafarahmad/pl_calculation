import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pl_calculation/core/database/base_model.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/core/usecase/usecase.dart';
import 'package:pl_calculation/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUsecase implements UseCase<BaseModel, ParamsResetPassword> {
  final AuthRepository repository;

  ResetPasswordUsecase(this.repository);

  Future<Either<Failure, BaseModel>> call(ParamsResetPassword params) async {
    return await repository.resetPassword(params);
  }
}

class ParamsResetPassword extends Equatable {
  final BuildContext? context;
  final String? oldPassword;
  final String? newPassword;

  ParamsResetPassword({
    this.context, this.oldPassword, this.newPassword,
  });

  @override
  List<Object> get props => [context!, oldPassword!, newPassword!];
}