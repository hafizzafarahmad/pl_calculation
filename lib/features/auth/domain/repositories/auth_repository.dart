import 'package:dartz/dartz.dart';
import 'package:pl_calculation/core/database/base_model.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/features/auth/data/models/login_model.dart';
import 'package:pl_calculation/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/login_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/resend_otp_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_otp_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_register_new_account_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, BaseModel>> register(ParamsRegister paramsRegister);
  Future<Either<Failure, LoginModel>> login(ParamsLogin paramsLogin);
  Future<Either<Failure, BaseModel>> sendOTP(ParamsOTP paramsOTP);
  Future<Either<Failure, BaseModel>> resendOTP(ParamsResentOtp paramsResentOtp);
  Future<Either<Failure, BaseModel>> forgotPassword(ParamsForgotPassword paramsForgotPassword);
  Future<Either<Failure, BaseModel>> resetPassword(ParamsResetPassword paramsResetPassword);
}