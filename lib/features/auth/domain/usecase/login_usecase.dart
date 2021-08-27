import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/core/usecase/usecase.dart';
import 'package:pl_calculation/features/auth/data/models/login_model.dart';
import 'package:pl_calculation/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase implements UseCase<LoginModel, ParamsLogin> {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, LoginModel>> call(ParamsLogin params) async {
    return await repository.login(params);
  }
}

class ParamsLogin extends Equatable {
  final BuildContext? context;
  final String? email;
  final String? password;

  ParamsLogin({
    @required this.email,
    @required this.password,
    this.context
  });

  @override
  List<Object> get props => [ email!,password!, context!];
}