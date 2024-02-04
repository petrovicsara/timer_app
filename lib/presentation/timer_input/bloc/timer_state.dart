import 'dart:math';
import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  @override
  List<Object> get props => [];
}

class TimerInitialState extends TimerState {}

class ListenState extends TimerState {}

class ErrorValueState extends ListenState {
  ErrorValueState(this.errorMessage);

  final String errorMessage;
  @override
  List<Object> get props => [errorMessage, Random(1000)];
}

class SuccessState extends ListenState {
  SuccessState(this.minutes);

  final int minutes;

  @override
  List<Object> get props => [minutes, Random(1000)];
}
