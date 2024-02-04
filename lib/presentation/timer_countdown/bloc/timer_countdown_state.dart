import 'package:equatable/equatable.dart';

abstract class TimerCountdownState extends Equatable {
  @override
  List<Object> get props => [];
}

class TimerCountdownInitialState extends TimerCountdownState {}

class ListenState extends TimerCountdownState {}

class StartTimerCountdownState extends TimerCountdownState {
  StartTimerCountdownState(this.timeLeft, {this.isPaused = false});

  final int timeLeft;
  final bool isPaused;

  @override
  List<Object> get props => [timeLeft, isPaused];
}

class SuccessState extends ListenState {
  SuccessState({required this.coins, required this.minutes});

  final int minutes;
  final int coins;

  @override
  List<Object> get props => [minutes, coins];
}

class QuitTimerState extends ListenState {}
