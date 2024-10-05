import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenith/app/constants/app_images.dart';
import 'package:zenith/app/themes/app_colors.dart';
import 'package:zenith/app/themes/app_paddings.dart';
import 'package:zenith/app/themes/app_text_field_themes.dart';
import 'package:zenith/core/extensions/routes_extenstion.dart';
import 'package:zenith/core/extensions/sizes_extensions.dart';
import 'package:zenith/core/extensions/text_theme_ext.dart';
import 'package:zenith/core/utils/loader.dart';
import 'package:zenith/features/home/providers/articles_provider.dart';
import 'package:zenith/features/home/screens/article_detail_screen.dart';

class ExploreArticlesScreen extends ConsumerWidget {
  const ExploreArticlesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureValue = ref.watch(articlesProvider);

    return Container(
      height: context.h,
      width: context.w,
      color: AppColors.backgroundColor,
      padding: AppPaddings.normal,
      child: futureValue.when(
        error: (error, stackTrace) {
          print("error : ${error.toString()} stackTrace: $stackTrace");
          return Text("error : ${error.toString()} ",
              style: const TextStyle(color: Colors.white));
        },
        loading: () => const Loader(),
        data: (data) => Column(
          children: [
            SizedBox(
              height: 50,
              child: TextField(
                cursorHeight: 25,
                controller: TextEditingController(),
                decoration: AppTextFieldDecorations.searchFieldDecoration,
              ),
            ),
            AppSizes.largeY,
            SizedBox(
              height: context.h * 0.7,
              width: double.infinity,
              child: ListView.builder(
                itemCount: data.results.length,
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     childAspectRatio: 0.9.sp,
                //     crossAxisSpacing: 15,
                //     crossAxisCount: 3),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    context.push(
                        ArticleDetailScreen(article: data.results[index]));
                  },
                  child: Container(
                    width: context.w * 0.9,
                    height: context.h * 0.1,
                    margin: AppPaddings.tinyY,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                        color: AppColors.blackshadowColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: data.results[index].imageUrl,
                              fit: BoxFit.cover,
                              height: 90.h,
                              width: 90.w,
                            )),
                        AppSizes.tinyX,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: context.w * 0.6,
                              child: Text(
                                data.results[index].title,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            AppSizes.tinyY,
                            SizedBox(
                              width: context.w * 0.6,
                              child: Text(
                                data.results[index].summary,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodySmall?.copyWith(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
