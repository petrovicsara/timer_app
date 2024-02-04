import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_timer_app/presentation/timer_input/bloc/timer_event.dart';
import 'package:my_timer_app/presentation/timer_input/bloc/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInitialState()) {
    on<SetTheTimerEvent>(_setTheTimer);
  }

  Future<void> _setTheTimer(SetTheTimerEvent event, Emitter<TimerState> emit) async {
    if (event.minutes == null) {
      emit(ErrorValueState('Field can not be blank'));
    } else {
      emit(SuccessState(event.minutes!));
    }
  }
}
