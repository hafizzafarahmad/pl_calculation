import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/core/usecase/usecase.dart';
import 'package:pl_calculation/features/listResult/domain/entities/list_result_entity.dart';
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
        yield ErrorDataNullListResultState();
      }, (r)async*{

        if(r.isNotEmpty){
          yield ListResultRetrievedState(listResult: r);
        } else {
          yield ErrorDataNullListResultState();
        }

      });
    }

    if(event is DeleteListResultEvent){
      loadingDialog(event.context!).style(message: 'Delete...');
      await loadingDialog(event.context!).show();

      final box = await Hive.openBox(BOX_MENU_LIST_RESULT);
      List<ListResultEntity>? listResult = [];

      for(int i=0; i < box.length; i++){
        listResult.add(box.getAt(i));
      }
      listResult.removeWhere((element) => element.name == event.name);

      await box.clear();

      for(int i=0; i < listResult.length; i++){
        box.add(listResult[i]);
      }

      event.context!.read<ListResultBloc>().add(GetListResultEvent());
      Navigator.pop(event.context!);

      await loadingDialog(event.context!).hide();

    }
  }

}