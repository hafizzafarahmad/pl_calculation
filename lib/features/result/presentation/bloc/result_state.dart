import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pl_calculation/features/result/data/models/result_model.dart';
import 'package:pl_calculation/features/result/domain/entities/result_entity.dart';

@immutable
abstract class ResultState extends Equatable {
  @override
  List<Object> get props => [];
}

class ResultInitializedState extends ResultState{}

class ResultRetrievedState extends ResultState {
  final ResultEntity? resultEntity;

  ResultRetrievedState(
      {this.resultEntity});


  @override
  List<Object> get props => [resultEntity!];
}

class ErrorResultState extends ResultState {
  final String messages;

  ErrorResultState(this.messages);

  @override
  String toString() => 'ERROR: $messages';

  @override
  List<Object> get props => [messages];
}

class LoadingResultState extends ResultState {}

