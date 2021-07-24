import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl_calculation/features/result/domain/usecase/get_result_usecase.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_event.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_state.dart';
import 'package:pl_calculation/features/result/presentation/pages/index_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState>{
  final GetResultUsecase? getResultUsecase;
  final SharedPreferences? sharedPreferences;


  ResultBloc({this.getResultUsecase, this.sharedPreferences, }) : super(LoadingResultState());

  @override
  Stream<ResultState> mapEventToState(ResultEvent event) async* {

    if(event is GetResultEvent){
      yield LoadingResultState();


      final remote = await getResultUsecase!.call(
          event.calculateEntity!);

      yield* remote.fold((l) async* {
        yield ErrorResultState('Terjadi kesalahan');
      }, (r)async*{
        yield ResultRetrievedState(resultEntity: r.data);
      });
    }
  }

}