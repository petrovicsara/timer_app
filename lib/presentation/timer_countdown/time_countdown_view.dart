import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_timer_app/design/colors.dart';
import 'package:my_timer_app/presentation/timer_countdown/bloc/timer_countdown_bloc.dart';
import 'package:my_timer_app/presentation/timer_countdown/bloc/timer_countdown_event.dart';
import 'package:my_timer_app/presentation/timer_countdown/bloc/timer_countdown_state.dart';
import 'package:my_timer_app/presentation/timer_countdown/widget/counter.dart';
import 'package:my_timer_app/presentation/timer_input/time_input_view.dart';
import 'package:my_timer_app/presentation/timer_mission_complete/mission_completed_view.dart';

class TimeCountdownView extends StatelessWidget {
  const TimeCountdownView({Key? key, required this.minutes}) : super(key: key);

  final int minutes;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerCountdownBloc()..add(TimerCountdownInitialEvent(minutes)),
      child: const TimerCountdownViewPage(),
    );
  }
}

class TimerCountdownViewPage extends StatefulWidget {
  const TimerCountdownViewPage({Key? key}) : super(key: key);

  @override
  State<TimerCountdownViewPage> createState() => _TimerCountdownViewPageState();
}

class _TimerCountdownViewPageState extends State<TimerCountdownViewPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerCountdownBloc, TimerCountdownState>(
      listenWhen: (_, current) => current is ListenState,
      listener: (context, state) {
        if (state is SuccessState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MissionCompletedView(minutes: state.minutes, coins: state.coins)));
        } else if (state is QuitTimerState) {
          Navigator.pop(context, MaterialPageRoute(builder: (context) => const TimerInputView()));
        }
      },
      builder: (context, state) {
        if (state is StartTimerCountdownState) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                stops: [0.0, 0.5],
                colors: [TimerColors.gradientColorOne, TimerColors.gradientColorOne],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: TimerColors.primaryText,
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: TimerColors.orange,
                ),
                centerTitle: false,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [TimerColors.gradientColorTwo, TimerColors.gradientColorOne],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: TimerColors.shadow1,
                          spreadRadius: 0,
                          blurRadius: 40,
                          offset: Offset(20, 10),
                        ),
                        BoxShadow(
                          color: TimerColors.shadow5,
                          spreadRadius: 0,
                          blurRadius: 42,
                          offset: Offset(-10, -10),
                        ),
                      ]),
                ),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Counter(timeLeft: state.timeLeft, isPaused: state.isPaused),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: TimerColors.shadow1,
                                  spreadRadius: 0,
                                  blurRadius: 19,
                                  offset: Offset(4, 3),
                                ),
                                BoxShadow(
                                  color: TimerColors.shadow2,
                                  spreadRadius: 0,
                                  blurRadius: 16,
                                  offset: Offset(-7, -7),
                                )
                              ],
                            ),
                            child: IconButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(TimerColors.gradientColorTwo),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      side: const BorderSide(color: Colors.transparent),
                                    ),
                                  )),
                              onPressed: () {
                                context.read<TimerCountdownBloc>().add(PauseResumeCounterEvent());
                              },
                              icon: state.isPaused ? const Icon(Icons.play_arrow_outlined) : const Icon(Icons.pause_outlined),
                              iconSize: 40,
                              color: TimerColors.orange,
                            ),
                          ),
                          Container(
                            height: 90,
                            width: 90,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: TimerColors.shadow1,
                                  spreadRadius: 0,
                                  blurRadius: 19,
                                  offset: Offset(4, 3),
                                ),
                                BoxShadow(
                                  color: TimerColors.shadow2,
                                  spreadRadius: 0,
                                  blurRadius: 16,
                                  offset: Offset(-7, -7),
                                )
                              ],
                            ),
                            child: IconButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(TimerColors.gradientColorTwo),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      side: const BorderSide(color: Colors.transparent),
                                    ),
                                  )),
                              onPressed: () {
                                context.read<TimerCountdownBloc>().add(QuitTimerEvent());
                              },
                              icon: const Icon(Icons.power_settings_new_outlined),
                              iconSize: 40,
                              color: TimerColors.orange,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
