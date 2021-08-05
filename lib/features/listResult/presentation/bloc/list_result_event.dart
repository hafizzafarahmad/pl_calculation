import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pl_calculation/features/result/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/domain/entities/result_entity.dart';

@immutable
abstract class ListResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListResultEvent extends ListResultEvent{
  final BuildContext? context;

  GetListResultEvent({this.context});

  @override
  List<Object> get props => [context!,];
}

class DeleteListResultEvent extends ListResultEvent{
  final BuildContext? context;
  final String? name;

  DeleteListResultEvent({this.context, this.name});

  @override
  List<Object> get props => [context!, name!];
}

