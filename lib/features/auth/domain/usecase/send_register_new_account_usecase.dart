import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pl_calculation/core/database/base_model.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/core/usecase/usecase.dart';
import 'package:pl_calculation/features/auth/domain/repositories/auth_repository.dart';

class SendRegisterNewAccountUsecase implements UseCase<BaseModel, ParamsRegister> {
  final AuthRepository repository;

  SendRegisterNewAccountUsecase(this.repository);

  Future<Either<Failure, BaseModel>> call(ParamsRegister params) async {
    return await repository.register(params);
  }
}

class ParamsRegister extends Equatable {
  final String? nama;
  final String? email;
  final String? password;

  ParamsRegister({
    @required this.nama,
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [nama!, email!,password!];
}