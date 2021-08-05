import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pl_calculation/features/result/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/domain/entities/result_entity.dart';

@immutable
abstract class ResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetResultEvent extends ResultEvent{
  final BuildContext? context;
  final CalculateEntity? calculateEntity;

  GetResultEvent({this.context, this.calculateEntity});

  @override
  List<Object> get props => [context!, calculateEntity!];
}

class SaveResultEvent extends ResultEvent{
  final BuildContext? context;
  final CalculateEntity? calculateEntity;
  final ResultEntity? resultEntity;
  final String? name;

  SaveResultEvent({this.context, this.calculateEntity, this.resultEntity, this.name});

  @override
  List<Object> get props => [context!, calculateEntity!, resultEntity!, name!];
}

