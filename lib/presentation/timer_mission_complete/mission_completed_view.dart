import 'package:flutter/material.dart';
import 'package:my_timer_app/design/colors.dart';

class MissionCompletedView extends StatelessWidget {
  const MissionCompletedView({Key? key, required this.minutes, required this.coins}) : super(key: key);

  final int minutes;
  final int coins;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [0.0, 0.5],
          colors: [TimerColors.gradientColorTwo, TimerColors.gradientColorOne],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Mission Completed',
                  style: TextStyle(
                    color: TimerColors.primaryText,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 42),
                //text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 59),
                  child: Text(
                    'Great job. You finished your mission in ${minutes}min. You earned',
                    style: const TextStyle(
                      color: TimerColors.primaryText,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  '$coins coins',
                  style: const TextStyle(
                    color: TimerColors.orange,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Image.asset('assets/images/coins_timer_app.png'),
                const SizedBox(height: 30),
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
                      int count = 0;
                      Navigator.of(context).popUntil((route) => count++ >= 2);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
