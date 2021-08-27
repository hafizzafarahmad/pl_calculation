
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pl_calculation/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:pl_calculation/features/auth/domain/repositories/auth_repository.dart';
import 'package:pl_calculation/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/login_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/resend_otp_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_otp_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_register_new_account_usecase.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pl_calculation/features/listResult/data/datasources/list_result_local_data_source.dart';
import 'package:pl_calculation/features/listResult/domain/repositories/list_result_repository.dart';
import 'package:pl_calculation/features/listResult/domain/usecase/get_list_result_cache_usecase.dart';
import 'package:pl_calculation/features/listResult/presentation/bloc/list_result_bloc.dart';
import 'package:pl_calculation/features/result/data/datasources/result_remote_data_source.dart';
import 'package:pl_calculation/features/result/domain/repositories/result_repository.dart';
import 'package:pl_calculation/features/result/domain/usecase/get_result_usecase.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/platform/permission.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/listResult/data/repositories/list_result_repository_impl.dart';
import 'features/result/data/repositories/result_repository_impl.dart';


final sl = GetIt.instance;

Future<void> init() async {
  ///-------------------------------BLOC----------------------------------
  //APPS FEATURES
  sl.registerFactory(() => ListResultBloc(
    getListResultCacheUsecase: sl(),
    sharedPreferences: sl()
  ));
  sl.registerFactory(() => ResultBloc(
    getResultUsecase: sl(),
    sharedPreferences: sl()
  ));
  ///AUTH
  sl.registerFactory(() => AuthBloc(
    sendRegisterNewAccountUsecase: sl(),
    loginUsecase: sl(),
    sendOTPUsecase: sl(),
    resendOtpUsecase: sl(),
    sharedPreferences: sl(),
    permissionChecker: sl(),
    forgotPasswordUsecase: sl(),
    resetPasswordUsecase: sl()
  ));

  ///-------------------------------USE CASE----------------------------------
  ///RESULT
  sl.registerLazySingleton(() => GetListResultCacheUsecase(sl()));
  sl.registerLazySingleton(() => GetResultUsecase(sl()));
  ///AUTH
  sl.registerLazySingleton(() => SendRegisterNewAccountUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => SendOTPUsecase(sl()));
  sl.registerLazySingleton(() => ResendOtpUsecase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUsecase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));

  ///-------------------------------REPOSITORY----------------------------------
  ///APP FEATURES
  sl.registerLazySingleton<ListResultRepository>(() =>
      ListResultRepositoryImpl(listResultLocalDataSource: sl(),),);
  ///AUTH
  sl.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl( authRemoteDataSource: sl(), authLocalDataSource: sl(), networkInfo: sl()));
  ///RESULT
  sl.registerLazySingleton<ResultRepository>(() =>
      ResultRepositoryImpl( resultRemoteDataSource: sl()),);


  ///-------------------------------DATA SOURCE---------------------------------
  //AUTH
  sl.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(client: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
          () => AuthLocalDataSourceImpl());
  //result
  sl.registerLazySingleton<ListResultLocalDataSource>(
          () => ListResultLocalDataSourceImpl());
  sl.registerLazySingleton<ResultRemoteDataSource>(
          () => ResultRemoteDataSourceImpl(client: sl(), sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<PermissionChecker>(() => PermissionCheckerImpl());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}
