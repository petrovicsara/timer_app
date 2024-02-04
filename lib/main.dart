import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_timer_app/presentation/timer_input/bloc/timer_bloc.dart';
import 'package:my_timer_app/presentation/timer_input/time_input_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimerBloc>(
      create: (context) => TimerBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Timer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        home: const TimerInputView(),
      ),
    );
  }
}
