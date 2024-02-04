import 'package:flutter/material.dart';
import 'package:my_timer_app/design/colors.dart';

class Counter extends StatelessWidget {
  const Counter({Key? key, required this.timeLeft, required this.isPaused}) : super(key: key);

  final int timeLeft;
  final bool isPaused;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 98),
      height: 398,
      width: 398,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          stops: [0.0, 0.5],
          colors: [TimerColors.gradientColorOne, TimerColors.gradientColorOne],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
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
      child: Center(
        child: Container(
          height: 334,
          width: 334,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: TimerColors.lightBackground,
            boxShadow: [
              BoxShadow(
                color: TimerColors.lightBackground,
                spreadRadius: 0,
                blurRadius: 7,
                offset: Offset(1, 1),
              ),
              BoxShadow(
                color: TimerColors.shadow1,
                spreadRadius: 0,
                blurRadius: 8,
                offset: Offset(3, 3),
              )
            ],
          ),
          child: Center(
            child: Container(
              width: 309,
              height: 309,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  stops: [0.0, 0.9],
                  colors: [TimerColors.gradientColorOne, TimerColors.orange],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${((timeLeft / 60) ~/ 60).toString().padLeft(2, '0')}:${((timeLeft / 60) % 60).toInt().toStringAsFixed(0).padLeft(2, '0')}:${timeLeft.remainder(60).toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 48,
                      color: TimerColors.primaryText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    isPaused ? 'PAUSED' : 'REMAINING TIME',
                    style: const TextStyle(
                      fontSize: 14,
                      color: TimerColors.primaryText,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
