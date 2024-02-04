import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_timer_app/design/colors.dart';
import 'package:my_timer_app/presentation/timer_countdown/time_countdown_view.dart';
import 'package:my_timer_app/presentation/timer_input/bloc/timer_bloc.dart';
import 'package:my_timer_app/presentation/timer_input/bloc/timer_event.dart';
import 'package:my_timer_app/presentation/timer_input/bloc/timer_state.dart';

class TimerInputView extends StatelessWidget {
  const TimerInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimerBloc>(
      create: (BuildContext context) => TimerBloc(),
      child: const TimerInputViewPage(),
    );
  }
}

class TimerInputViewPage extends StatelessWidget {
  const TimerInputViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;
    var middleHeight = MediaQuery.of(context).size.height / 2;
    final TextEditingController minutesTimerController = TextEditingController();
    return BlocListener<TimerBloc, TimerState>(
        listenWhen: (_, current) => current is ListenState,
        listener: (context, state) {
          if (state is ErrorValueState) {
            Fluttertoast.showToast(
              msg: state.errorMessage,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: TimerColors.shadow3,
              textColor: TimerColors.orange,
            );
          } else if (state is SuccessState) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TimeCountdownView(minutes: state.minutes)));
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              stops: [0.0, 0.5],
              colors: [TimerColors.gradientColorTwo, TimerColors.gradientColorOne],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Timer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: TimerColors.primaryText,
                ),
              ),
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
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 59, right: 59, top: middleHeight / 2 + safePadding),
                      child: const Text(
                        'Enter amount of time needed to complete a mission in minutes',
                        style: TextStyle(
                          color: TimerColors.primaryText,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 34),
                    Container(
                      height: 52,
                      width: 228,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.0, 0.7],
                          colors: [TimerColors.gradientColorOne, TimerColors.gradientColorTwo],
                        ),
                        boxShadow: const [
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
                          ),
                          BoxShadow(
                            color: TimerColors.shadow3,
                            spreadRadius: 0,
                            blurRadius: 16,
                            offset: Offset(1, 1),
                          ),
                          BoxShadow(
                            color: TimerColors.shadow4,
                            spreadRadius: 0,
                            blurRadius: 16,
                            offset: Offset(-1, -1),
                          ),
                        ],
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[1-9][0-9]*')),
                        ],
                        controller: minutesTimerController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 31, vertical: 17),
                      height: 64,
                      width: 228,
                      decoration: const BoxDecoration(
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
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(TimerColors.orange),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                                side: const BorderSide(color: Colors.transparent),
                              ),
                            )),
                        onPressed: () {
                          context.read<TimerBloc>().add(SetTheTimerEvent(int.tryParse(minutesTimerController.text)));
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 77),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
