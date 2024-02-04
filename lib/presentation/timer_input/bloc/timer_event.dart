import 'dart:math';

import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetTheTimerEvent extends TimerEvent {
  SetTheTimerEvent(this.minutes);

  final int? minutes;

  @override
  List<Object?> get props => [minutes, Random(1000)];
}
