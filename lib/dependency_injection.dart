
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pl_calculation/features/listResult/data/datasources/list_result_remote_data_source.dart';
import 'package:pl_calculation/features/listResult/domain/repositories/list_result_repository.dart';
import 'package:pl_calculation/features/listResult/domain/usecase/get_list_result_usecase.dart';
import 'package:pl_calculation/features/listResult/presentation/bloc/list_result_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/permission.dart';
import 'features/listResult/data/repositories/list_pengajuan_repository_impl.dart';


final sl = GetIt.instance;

Future<void> init() async {
  ///-------------------------------BLOC----------------------------------
  //APPS FEATURES
  sl.registerFactory(() => ListResultBloc());

  ///-------------------------------USE CASE----------------------------------
  ///APPS FEATURES
  sl.registerLazySingleton(() => GetListResultUsecase(sl()));

  ///-------------------------------REPOSITORY----------------------------------
  ///APP FEATURES
  sl.registerLazySingleton<ListResultRepository>(() =>
      ListResultRepositoryImpl(listResultRemoteDataSource: sl(),),);


  ///-------------------------------DATA SOURCE---------------------------------
  sl.registerLazySingleton<ListResultRemoteDataSource>(
        () => ListResultRemoteDataSourceImpl());

  //! Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<PermissionChecker>(() => PermissionCheckerImpl());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}
