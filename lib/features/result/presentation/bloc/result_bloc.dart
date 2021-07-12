import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl_calculation/features/result/domain/usecase/get_result_usecase.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_event.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState>{
  final GetResultUsecase? getResultUsecase;
  final SharedPreferences? sharedPreferences;

  ResultBloc({this.getResultUsecase, this.sharedPreferences, }) : super(ResultInitializedState());

  @override
  Stream<ResultState> mapEventToState(ResultEvent event) async* {

    if(event is GetResultEvent){
      yield LoadingResultState();

      final result = await getResultUsecase!.call(event.calculateEntity);
    }
  }

}