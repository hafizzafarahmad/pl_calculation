import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pl_calculation/features/listResult/data/models/list_pengajuan_model.dart';

@immutable
abstract class ListResultState extends Equatable {
  @override
  List<Object> get props => [];
}

class ListResultInitializedState extends ListResultState{}

class ListResultRetrievedState extends ListResultState {
  final ListResultModel? listResultModel;

  ListResultRetrievedState(
      {
      this.listResultModel,});


  @override
  List<Object> get props => [listResultModel!];
}

class ErrorListResultState extends ListResultState {
  final String messages;

  ErrorListResultState(this.messages);

  @override
  String toString() => 'ERROR: $messages';

  @override
  List<Object> get props => [messages];
}

class LoadingListResultState extends ListResultState {}

class ListResultDataNullState extends ListResultState {}

