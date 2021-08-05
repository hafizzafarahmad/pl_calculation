import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl_calculation/core/usecase/usecase.dart';
import 'package:pl_calculation/features/listResult/domain/usecase/get_list_result_cache_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'list_result_event.dart';
import 'list_result_state.dart';

class ListResultBloc extends Bloc<ListResultEvent, ListResultState>{
  final GetListResultCacheUsecase? getListResultCacheUsecase;
  final SharedPreferences? sharedPreferences;


  ListResultBloc({this.getListResultCacheUsecase, this.sharedPreferences, }) : super(LoadingListResultState());

  @override
  Stream<ListResultState> mapEventToState(ListResultEvent event) async* {

    if(event is GetListResultEvent){
      yield LoadingListResultState();


      final remote = await getListResultCacheUsecase!.call(NoParams());

      yield* remote.fold((l) async* {
        yield ErrorListResultState('Terjadi kesalahan');
      }, (r)async*{

        if(r.isNotEmpty){
          yield ListResultRetrievedState(listResult: r);
        } else {
          yield ErrorDataNullListResultState();
        }

      });
    }
  }

}