import 'package:flutter/material.dart';
import 'package:zenith/app/themes/app_colors.dart';
import 'package:zenith/core/extensions/routes_extenstion.dart';
import 'package:zenith/features/auth/screens/widgets/app_bar_white.dart';
import 'package:zenith/features/auth/screens/widgets/button.dart';

class QuizResultScreen extends StatelessWidget {
  final bool isPassed;
  final int score;
  final int totalQuestions;
  final int attemptCount;
  final DateTime startTime;
  final DateTime endTime;

  const QuizResultScreen({
    Key? key,
    required this.isPassed,
    required this.score,
    required this.totalQuestions,
    required this.attemptCount,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Duration calculation for quiz time
    final quizDuration = endTime.difference(startTime);
    final formattedStartTime =
        "${startTime.hour}:${startTime.minute}:${startTime.second}";
    final formattedEndTime =
        "${endTime.hour}:${endTime.minute}:${endTime.second}";

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: CustomAppBar(
          enableBackButton: true,
          onPressed: () {},
          text: "Quiz Result",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Message whether passed or failed
            Text(
              isPassed ? 'Congratulations! You Passed!' : 'Sorry, You Failed!',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isPassed ? Colors.green : Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Final score
            Text('$score / $totalQuestions',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: AppColors.textWhiteColor)),

            const SizedBox(height: 20),

            // Number of attempts
            Text(
              'Attempts: $attemptCount',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Start time of the quiz
            Text(
              'Quiz Start Time: $formattedStartTime',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // End time of the quiz
            Text(
              'Quiz End Time: $formattedEndTime',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Duration of the quiz
            Text(
              'Total Duration: ${quizDuration.inMinutes} minutes and ${quizDuration.inSeconds % 60} seconds',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            Button(press: () => context.pop(), text: "Return to Home"),
          ],
        ),
      ),
    );
  }
}
