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
import 'package:pl_calculation/features/auth/domain/usecase/login_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_register_new_account_usecase.dart';


class AuthRepositoryImpl implements AuthRepository{
  final AuthLocalDataSource? authLocalDataSource;
  final AuthRemoteDataSource? authRemoteDataSource;
  final NetworkInfo? networkInfo;

  AuthRepositoryImpl(
      {this.authLocalDataSource, this.authRemoteDataSource, this.networkInfo});


  @override
  Future<Either<Failure, BaseModel>> register(ParamsRegister paramsRegister) async {
    if(await networkInfo!.isConnected){
      try{
        final register = await authRemoteDataSource!.sendRegister(paramsRegister);
        return Right(register);
      }on ServerException{
        return Left(ServerFailure());
      }

    }else{
      alertToast('Tidak ada koneksi Internet');
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, LoginModel>> login(ParamsLogin paramsLogin) async {
    if(await networkInfo!.isConnected){
      try{
        final login = await authRemoteDataSource!.sendLogin(paramsLogin);
        return Right(login);
      }on ServerException{
        return Left(ServerFailure());
      }

    }else{
      alertToast('Tidak ada koneksi Internet');
      return Left(CacheFailure());
    }
  }

}