import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pl_calculation/features/calculate/domain/entities/calculate_entity.dart';

@immutable
abstract class ResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetResultEvent extends ResultEvent{
  final BuildContext context;
  final CalculateEntity calculateEntity;

  GetResultEvent(this.context, this.calculateEntity);

  @override
  List<Object> get props => [context, calculateEntity];
}

