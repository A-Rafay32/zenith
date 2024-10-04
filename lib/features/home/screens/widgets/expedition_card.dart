import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenith/app/themes/app_styles.dart';
import 'package:zenith/app/themes/app_colors.dart';
import 'package:zenith/app/themes/app_paddings.dart';
import 'package:zenith/core/extensions/routes_extenstion.dart';
import 'package:zenith/features/expedition/screen/expedition_detail_screen.dart';
import 'package:zenith/features/home/screens/widgets/house_image_view.dart';

class ExpeditionCardWidget extends StatefulWidget {
  const ExpeditionCardWidget({
    super.key,
    required this.image,
    required this.description,
    required this.name,
    required this.id,
    required this.onTapFav,
  });

  final Function() onTapFav;
  final String name;
  final String id;
  final String description;
  final String image;

  @override
  State<ExpeditionCardWidget> createState() => _ExpeditionCardWidgetState();
}

class _ExpeditionCardWidgetState extends State<ExpeditionCardWidget> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(428, 926));

    return GestureDetector(
      onTap: () => context.push(ExpeditionDetailScreen(
        expeditionId: widget.id.toString(),
        expeditionName: widget.name.toString(),
      )),
      child: Container(
          padding: AppPaddings.tiny,
          decoration: BoxDecoration(
            // boxShadow: AppStyles.boxShadow,
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            // mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: widget.image.toString(),
                width: 300.w,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              // HouseImageView(
              //   width: 300.w,
              //   isPremium: true,
              //   productImage: widget.image,
              //   context: context,
              // ),
              AppSizes.smallY,
              Positioned(bottom: 10, left: 5, child: productDetails(context)),
            ],
          )),
    );
  }

  Column productDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.name.toString(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textWhiteColor,
              ),
        ),
        AppSizes.tinyY,
        Text(
          widget.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontSize: 10.sp, color: AppColors.textWhiteColor),
        ),
      ],
    );
  }
}
