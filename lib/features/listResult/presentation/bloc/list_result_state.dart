import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pl_calculation/features/listResult/domain/entities/list_result_entity.dart';

@immutable
abstract class ListResultState extends Equatable {
  @override
  List<Object> get props => [];
}

class ListResultRetrievedState extends ListResultState {
  final List<ListResultEntity>? listResult;

  ListResultRetrievedState(
      {this.listResult});


  @override
  List<Object> get props => [listResult!];
}

class ErrorListResultState extends ListResultState {
  final String messages;

  ErrorListResultState(this.messages);

  @override
  String toString() => 'ERROR: $messages';

  @override
  List<Object> get props => [messages];
}

class ErrorDataNullListResultState extends ListResultState {}

class LoadingListResultState extends ListResultState {}

