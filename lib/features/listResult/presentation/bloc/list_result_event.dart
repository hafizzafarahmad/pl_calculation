import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ListResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ListResultInitializedEvent extends ListResultEvent{
  final BuildContext context;

  ListResultInitializedEvent(this.context);

  @override
  List<Object> get props => [context];
}

