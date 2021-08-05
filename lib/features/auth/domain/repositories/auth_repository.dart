import 'package:dartz/dartz.dart';
import 'package:pl_calculation/core/database/base_model.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/features/auth/data/models/login_model.dart';
import 'package:pl_calculation/features/auth/domain/usecase/login_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_register_new_account_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, BaseModel>> register(ParamsRegister paramsRegister);
  Future<Either<Failure, LoginModel>> login(ParamsLogin paramsLogin);
}