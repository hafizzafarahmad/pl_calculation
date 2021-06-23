import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl_calculation/core/usecase/usecase.dart';
import 'package:pl_calculation/features/listResult/domain/usecase/get_list_result_usecase.dart';
import 'package:pl_calculation/features/listResult/presentation/bloc/list_result_state.dart';

import 'list_result_event.dart';

class ListResultBloc extends Bloc<ListResultEvent, ListResultState>{
  final GetListResultUsecase? getListResultUsecase;

  ListResultBloc( {this.getListResultUsecase}) : super(ListResultInitializedState());

  @override
  Stream<ListResultState> mapEventToState(ListResultEvent event) async* {

    if(event is ListResultInitializedEvent){
      yield LoadingListResultState();
      final listResult = await getListResultUsecase!.call(NoParams());

      yield* listResult.fold((l) async* {
        yield ErrorListResultState('Terjadi kesalahan');
      }, (r)async*{
        if(r.code == 200){
          yield ListResultRetrievedState(listResultModel: r);
        }else{
          yield ListResultDataNullState();
        }

      });
    }
  }

}