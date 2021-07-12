import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pl_calculation/features/result/data/models/list_notification_model.dart';

@immutable
abstract class ResultState extends Equatable {
  @override
  List<Object> get props => [];
}

class ResultInitializedState extends ResultState{}

class ResultRetrievedState extends ResultState {
  final ResultModel? resultModel;

  ResultRetrievedState(
      {this.resultModel});


  @override
  List<Object> get props => [resultModel!];
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

