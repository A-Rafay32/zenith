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
import 'package:zenith/features/auth/providers/auth_providers.dart';
import 'package:zenith/features/auth/screens/widgets/app_bar_white.dart';
import 'package:zenith/features/auth/screens/widgets/button.dart';
import 'package:zenith/features/expedition/model/expedtion_detail.dart';
import 'package:zenith/features/expedition/providers/provider.dart';
import 'package:zenith/features/quiz/model/quiz_session.dart';
import 'package:zenith/features/quiz/providers/quiz_session_notifier.dart';
import 'package:zenith/features/quiz/screen/quiz_detail_screen.dart';

class ExpeditionDetailScreen extends ConsumerWidget {
  const ExpeditionDetailScreen({
    super.key,
    required this.expeditionName,
    required this.expeditionId,
  });

  final String expeditionName;
  final String expeditionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamValue = ref.watch(expeditionDetailStreamProvider(expeditionId));

    return streamValue.when(
        data: (data) {
          List<Widget> pages = List.generate(
              data.length,
              (index) => Page1(
                    isLastPage: index != data.length - 1 ? false : true,
                    expeditionId: expeditionId,
                    expeditionName: expeditionName,
                    expeditionDetail: data[index],
                  ));

          return Scaffold(
            // appBar: PreferredSize(
            //   preferredSize: const Size.fromHeight(65),
            //   child: CustomAppBar(
            //     enableBackButton: false,
            //     onPressed: () {},
            //     text: expeditionName,
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

class Page1 extends ConsumerWidget {
  const Page1({
    super.key,
    required this.expeditionDetail,
    required this.expeditionName,
    required this.expeditionId,
    required this.isLastPage,
  });

  final ExpeditionDetail expeditionDetail;
  final String expeditionName;
  final String expeditionId;
  final bool isLastPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: context.h,
      width: context.w,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: expeditionDetail.image ?? AppImages.defaultImage,
              // imageBuilder: (context, imageProvider) => Container(
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: imageProvider,
              //       fit: BoxFit.cover,
              //       colorFilter: const ColorFilter.mode(
              //         Colors.red,
              //         BlendMode.colorBurn,
              //       ),
              //     ),
              //   ),
              // ),
              placeholder: (context, url) => Image.asset(
                AppImages.defaultImage,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              errorWidget: (context, url, error) => Image.asset(
                AppImages.defaultImage,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: context.w * 0.5,
            child: Text(
              expeditionName,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 16.sp, color: AppColors.textWhiteColor),
            ),
          ),
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
            top: context.h * 0.5,
            child: Container(
              height: context.h * 0.5,
              width: context.w,
              padding: AppPaddings.normal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(expeditionDetail.text,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: AppColors.textWhiteColor)),
                  AppSizes.largeY,
                  Text(
                    expeditionDetail.description,
                    maxLines: 8,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        // fontSize: 6.sp,
                        color: AppColors.textWhiteColor),
                  ),
                ],
              ),
            ),
          ),
          if (isLastPage)
            Positioned(
                bottom: 10,
                left: context.w * 0.5,
                child: Button(
                    press: () async {
                      String? userId = ref.read(currentUserProvider)?.uid;
                      print(userId);

                      QuizSession quizSession = QuizSession(
                          id: generateId(),
                          quizId: "",
                          userId: userId.toString(),
                          userAnswers: [],
                          currentScore: 0,
                          attemptCount: 1,
                          startTime: DateTime.now());

                      ref
                          .read(quizSessionNotifierProvider.notifier)
                          .createQuizSession(quizSession, context);

                      ref.context.push(QuizDetailScreen(
                          quizName: "", expeditionId: expeditionId));
                    },
                    text: "Go to Quiz")),
        ],
      ),
    );
  }
}
