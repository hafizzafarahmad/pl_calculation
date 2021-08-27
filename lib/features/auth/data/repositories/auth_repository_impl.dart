import 'package:dartz/dartz.dart';
import 'package:pl_calculation/core/database/base_model.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/core/network/network_info.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:pl_calculation/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pl_calculation/features/auth/data/models/login_model.dart';
import 'package:pl_calculation/features/auth/domain/repositories/auth_repository.dart';
import 'package:pl_calculation/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/login_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/resend_otp_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_otp_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_register_new_account_usecase.dart';


class AuthRepositoryImpl implements AuthRepository{
  final AuthLocalDataSource? authLocalDataSource;
  final AuthRemoteDataSource? authRemoteDataSource;
  final NetworkInfo? networkInfo;

  AuthRepositoryImpl(
      {this.authLocalDataSource, this.authRemoteDataSource, this.networkInfo});


  @override
  Future<Either<Failure, BaseModel>> register(ParamsRegister paramsRegister) async {
    try{
      final register = await authRemoteDataSource!.sendRegister(paramsRegister);
      return Right(register);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, LoginModel>> login(ParamsLogin paramsLogin) async {
    try{
      final login = await authRemoteDataSource!.sendLogin(paramsLogin);
      return Right(login);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BaseModel>> resendOTP(ParamsResentOtp paramsResentOtp) async {
    try{
      final remote = await authRemoteDataSource!.resendCode(paramsResentOtp);
      return Right(remote);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BaseModel>> sendOTP(ParamsOTP paramsOTP) async {
    try{
      final remote = await authRemoteDataSource!.verifyAccount(paramsOTP);
      return Right(remote);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BaseModel>> forgotPassword(ParamsForgotPassword paramsForgotPassword) async {
    try{
      final remote = await authRemoteDataSource!.forgotPassword(paramsForgotPassword);
      return Right(remote);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BaseModel>> resetPassword(ParamsResetPassword paramsResetPassword) async {
    try{
      final remote = await authRemoteDataSource!.resetPassword(paramsResetPassword);
      return Right(remote);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

}