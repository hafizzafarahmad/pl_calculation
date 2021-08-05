import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/features/listResult/domain/entities/list_result_entity.dart';
import 'package:pl_calculation/features/listResult/presentation/bloc/list_result_event.dart';
import 'package:pl_calculation/features/result/domain/usecase/get_result_usecase.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_event.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_state.dart';
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
          ParamsCalculation(
            context: event.context,
            calculateEntity: event.calculateEntity!
          ));

      yield* remote.fold((l) async* {
        yield ErrorResultState('Terjadi kesalahan');
      }, (r)async*{
        yield ResultRetrievedState(resultEntity: r.data);
      });
    }

    if(event is SaveResultEvent){
      loadingDialog(event.context!).style(message: 'Saving...');
      await loadingDialog(event.context!).show();

      final box = await Hive.openBox(BOX_MENU_LIST_RESULT);

      box.add(ListResultEntity(
        calculateEntity: event.calculateEntity,
        resultEntity: event.resultEntity,
        name: event.name,
        createdAt: DateTime.now().toString()
      ));

      Navigator.pop(event.context!);
      alertToast("Data Saved");

      await loadingDialog(event.context!).hide();
    }
  }

}