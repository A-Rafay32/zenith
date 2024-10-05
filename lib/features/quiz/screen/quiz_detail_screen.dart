import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenith/app/constants/app_images.dart';
import 'package:zenith/app/themes/app_colors.dart';
import 'package:zenith/app/themes/app_paddings.dart';
import 'package:zenith/core/extensions/routes_extenstion.dart';
import 'package:zenith/core/extensions/sizes_extensions.dart';
import 'package:zenith/core/utils/gen_random_ids.dart';
import 'package:zenith/core/utils/loader.dart';
import 'package:zenith/features/auth/screens/widgets/app_bar_white.dart';
import 'package:zenith/features/auth/screens/widgets/button.dart';
import 'package:zenith/features/expedition/model/expedtion_detail.dart';
import 'package:zenith/features/expedition/providers/expedition_provider.dart';
import 'package:zenith/features/quiz/model/question.dart';
import 'package:zenith/features/quiz/model/quiz.dart';
import 'package:zenith/features/quiz/model/quiz_session.dart';
import 'package:zenith/features/quiz/providers/question_providers.dart';
import 'package:zenith/features/quiz/providers/quiz_providers.dart';
import 'package:zenith/features/quiz/providers/quiz_session_notifier.dart';
import 'package:zenith/features/quiz/screen/quiz_result_screen.dart';
import 'package:zenith/features/user_quiz.dart/model/user_quiz.dart';
import 'package:zenith/features/user_quiz.dart/providers/user_quiz_notifier.dart';

class QuizDetailScreen extends ConsumerWidget {
  const QuizDetailScreen({
    super.key,
    required this.quiz,
    required this.expeditionId,
    required this.quizSessionId,
  });

  final Quiz quiz;
  final String expeditionId;
  final String quizSessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamValue = ref.watch(questionStreamProvider(expeditionId));
    // final quizValue = ref.watch(getQuizByExpeditionIdProvider(expeditionId));

    // Quiz? q;

    // quizValue.when(
    //     data: (data) => q = data,
    //     error: (error, stackTrace) {},
    //     loading: () {});

    return Scaffold(
      body: streamValue.when(
          data: (data) {
            List<Widget> pages = List.generate(
                data.length,
                (index) => QuizPage(
                      totalIndexes: data.length,
                      quiz: quiz,
                      isLastPage: index != data.length - 1 ? false : true,
                      quizSessionId: quizSessionId,
                      index: index,
                      question: data[index],
                    ));
            return PageView(children: pages);
          },
          error: (error, stackTrace) {
            print("error : ${error.toString()} stackTrace: $stackTrace");
            return Text("error : ${error.toString()} ",
                style: const TextStyle(color: Colors.white));
          },
          loading: () => const Loader()),
    );
  }
}

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({
    super.key,
    required this.question,
    required this.quiz,
    required this.index,
    required this.quizSessionId,
    required this.isLastPage,
    required this.totalIndexes,
  });

  final Question question;
  final Quiz quiz;
  final int index;
  final String quizSessionId;
  final bool isLastPage;
  final int totalIndexes;

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

final scoreProvider = StateProvider((ref) => 0);

class _QuizPageState extends ConsumerState<QuizPage> {
  List<bool> userAnswers = [];

  bool userAnswer = false;

  @override
  void initState() {
    super.initState();
    userAnswers =
        List.generate(widget.question.options.length, (index) => false);
  }

  String selectedAnswer = '';

  @override
  Widget build(BuildContext context) {
    // String userAnswer = widget.question.options[0];

    return SizedBox(
      height: context.h,
      width: context.w,
      child: Stack(
        children: [
          Image.asset(
            AppImages.splashImage2,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: AppPaddings.normal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image.asset(
                //   AppImages.defaultImage,
                //   fit: BoxFit.cover,
                //   height: double.infinity,
                //   width: double.infinity,
                // ),
                AppSizes.largeY,
                AppSizes.largeY,
                AppSizes.largeY,
                AppSizes.largeY,
                AppSizes.largeY,
                Text("Question ${widget.index + 1}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textWhiteColor.withOpacity(0.3))),
                AppSizes.normalY,
                Text(widget.question.questionText,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 25.sp,
                        color: AppColors.textWhiteColor.withOpacity(0.6))),
                AppSizes.largeY,
                ...List.generate(
                  widget.question.options.length,
                  (index) => Container(
                    padding: AppPaddings.normal,
                    margin: EdgeInsets.symmetric(vertical: 10.w),
                    decoration: BoxDecoration(
                        color: AppColors.blackshadowColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Checkbox(
                            value: userAnswers[index],
                            onChanged: (value) {
                              setState(() {
                                for (int i = 0; i < userAnswers.length; i++) {
                                  userAnswers[i] =
                                      (i == index) ? value! : false;
                                }
                                selectedAnswer = widget.question.options[index];
                                print(selectedAnswer);
                              });

                              if (selectedAnswer ==
                                  widget.question.correctAnswer) {
                                ref.read(scoreProvider.notifier).state += 1;
                                int score =
                                    ref.read(scoreProvider.notifier).state;
                                ref
                                    .read(quizSessionNotifierProvider.notifier)
                                    .updateQuizSession(widget.quizSessionId,
                                        {"currentScore": score}, context);
                              }
                            }),
                        AppSizes.smallX,
                        Text(
                          widget.question.options[index],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  // fontSize: 6.sp,
                                  color: AppColors.textWhiteColor
                                      .withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                if (widget.isLastPage)
                  Center(
                    child: Button(
                        press: () async {
                          await ref
                              .read(quizSessionNotifierProvider.notifier)
                              .getQuizSession(widget.quizSessionId, context)
                              .then((value) {
                            UserQuiz userQuiz = UserQuiz(
                                id: generateId(),
                                quizId: value.quizId,
                                userAnswers: value.userAnswers ?? [],
                                finalScore: value.currentScore,
                                userId: value.userId,
                                isPassed: value.currentScore >=
                                        widget.quiz.passingCriteria
                                    ? true
                                    : false,
                                completionTime: DateTime.now(),
                                attemptCount: value.attemptCount);

                            ref.read(userQuizNotifier.notifier).addUserQuiz(
                                userQuiz: userQuiz,
                                adminId: userQuiz.userId,
                                context: context);

                            showDialog(
                                context: context,
                                builder: (context) => QuizResultScreen(
                                      isPassed: userQuiz.isPassed,
                                      score: userQuiz.finalScore,
                                      totalQuestions: widget.totalIndexes,
                                      attemptCount: 1,
                                      // startTime: quizSe,
                                      // endTime: DateTime.now()
                                    ));
                            ref
                                .read(quizSessionNotifierProvider.notifier)
                                .deleteQuizSession(
                                    widget.quizSessionId, context);
                          });
                        },
                        text: "Submit"),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
