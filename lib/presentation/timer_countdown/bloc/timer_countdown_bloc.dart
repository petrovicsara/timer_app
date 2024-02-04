import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_timer_app/presentation/timer_countdown/bloc/timer_countdown_event.dart';
import 'package:my_timer_app/presentation/timer_countdown/bloc/timer_countdown_state.dart';

class TimerCountdownBloc extends Bloc<TimerCountdownEvent, TimerCountdownState> {
  TimerCountdownBloc() : super(TimerCountdownInitialState()) {
    on<TimerCountdownInitialEvent>(_init);
    on<StartCountdownEvent>(_startTimer);
    on<PauseResumeCounterEvent>(_pauseResumeTimer);
    on<QuitTimerEvent>(_quitTimer);
  }

  late int _inputMinutes;
  late int _seconds;
  late Timer _timer;
  late bool _isPaused;

  Future<void> _init(TimerCountdownInitialEvent event, Emitter<TimerCountdownState> emit) async {
    _inputMinutes = event.minutes;
    _seconds = event.minutes * 60;
    _isPaused = false;
    emit(StartTimerCountdownState(_seconds, isPaused: _isPaused));
    _timer = makePeriodicCall(const Duration(seconds: 1), (timer) async {
      add(StartCountdownEvent(_seconds));
    });
  }

  Future<void> _startTimer(StartCountdownEvent event, Emitter<TimerCountdownState> emit) async {
    if (_seconds > 0) {
      _seconds--;
      emit(StartTimerCountdownState(_seconds, isPaused: _isPaused));
    } else {
      _timer.cancel();
      emit(SuccessState(minutes: _inputMinutes, coins: _inputMinutes * 2));
    }
  }

  Future<void> _pauseResumeTimer(PauseResumeCounterEvent event, Emitter<TimerCountdownState> emit) async {
    _isPaused = !_isPaused;
    if (_isPaused) {
      _timer.cancel();
      emit(StartTimerCountdownState(_seconds, isPaused: _isPaused));
    } else {
      _timer = makePeriodicCall(const Duration(seconds: 1), (timer) async {
        add(StartCountdownEvent(_seconds));
      });
    }
  }

  Future<void> _quitTimer(QuitTimerEvent event, Emitter<TimerCountdownState> emit) async {
    emit(QuitTimerState());
  }

  Timer makePeriodicCall(
    Duration duration,
    void Function(Timer timer) callback, {
    bool fireNow = false,
  }) {
    var timer = Timer.periodic(duration, callback);
    if (fireNow) {
      callback(timer);
    }
    return timer;
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
