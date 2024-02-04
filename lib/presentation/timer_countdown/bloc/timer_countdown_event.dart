import 'package:equatable/equatable.dart';

abstract class TimerCountdownEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TimerCountdownInitialEvent extends TimerCountdownEvent {
  TimerCountdownInitialEvent(this.minutes);

  final int minutes;

  @override
  List<Object> get props => [minutes];
}

class StartCountdownEvent extends TimerCountdownEvent {
  StartCountdownEvent(this.seconds);

  final int seconds;

  @override
  List<Object> get props => [seconds];
}

class PauseResumeCounterEvent extends TimerCountdownEvent {}

class QuitTimerEvent extends TimerCountdownEvent {}
