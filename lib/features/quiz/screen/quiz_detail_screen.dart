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
import 'package:zenith/core/utils/loader.dart';
import 'package:zenith/features/expedition/model/expedtion_detail.dart';
import 'package:zenith/features/expedition/providers/provider.dart';
import 'package:zenith/features/quiz/model/question.dart';
import 'package:zenith/features/quiz/providers/question_providers.dart';
import 'package:zenith/features/quiz/providers/quiz_providers.dart';

class QuizDetailScreen extends ConsumerWidget {
  const QuizDetailScreen({
    super.key,
    required this.quizName,
    required this.expeditionId,
  });

  final String quizName;
  final String expeditionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamValue = ref.watch(questionStreamProvider(expeditionId));

    return streamValue.when(
        data: (data) {
          List<Widget> pages = List.generate(
              data.length,
              (index) => QuizPage(
                    index: index,
                    question: data[index],
                  ));

          return Scaffold(
            // appBar: PreferredSize(
            //   preferredSize: const Size.fromHeight(65),
            //   child: CustomAppBar(
            //     enableBackButton: false,
            //     onPressed: () {},
            //     text: quizName,
            //   ),
            // ),
            body: PageView(children: pages),
          );
        },
        error: (error, stackTrace) {
          print("error : ${error.toString()} stackTrace: $stackTrace");
          return Text("error : ${error.toString()} ",
              style: const TextStyle(color: Colors.white));
        },
        loading: () => const Loader());
  }
}

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({
    super.key,
    required this.question,
    required this.index,
  });

  final Question question;
  final int index;

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  List<bool> userAnswers = [];

  bool userAnswer = false;

  @override
  void initState() {
    super.initState();
    userAnswers =
        List.generate(widget.question.options.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    // String userAnswer = widget.question.options[0];

    return SizedBox(
      height: context.h,
      width: context.w,
      child: Stack(
        children: [
          Image.asset(
            AppImages.defaultImage,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          // Positioned(
          //   top: 20,
          //   left: context.w * 0.5,
          //   child: Text(
          //     quizName,
          //     style: Theme.of(context)
          //         .textTheme
          //         .titleLarge
          //         ?.copyWith(fontSize: 16.sp, color: AppColors.textWhiteColor),
          //   ),
          // ),
          Positioned(
            top: 10,
            left: 10,
            child: CupertinoNavigationBarBackButton(
                color: AppColors.textWhiteColor,
                onPressed: () {
                  context.pop();
                }),
          ),
          Positioned(
            top: context.h * 0.4,
            child: Container(
              height: context.h * 0.6,
              width: context.w,
              padding: AppPaddings.normal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Question ${widget.index + 1}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textWhiteColor)),
                  AppSizes.normalY,
                  Text(widget.question.questionText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.textWhiteColor)),
                  AppSizes.largeY,
                  ...List.generate(
                    widget.question.options.length,
                    (index) => Row(
                      children: [
                        Checkbox(
                            value: userAnswers[index],
                            onChanged: (value) {
                              setState(() {
                                for (int i = 0; i < userAnswers.length; i++) {
                                  userAnswers[i] =
                                      (i == index) ? value! : false;
                                }
                              });
                            }),
                        AppSizes.smallX,
                        Text(
                          widget.question.options[index],
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                  // fontSize: 6.sp,
                                  color: AppColors.textWhiteColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
