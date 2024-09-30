import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenith/app/themes/app_colors.dart';
import 'package:zenith/app/themes/app_paddings.dart';
import 'package:zenith/app/themes/app_text_field_themes.dart';
import 'package:zenith/core/extensions/routes_extenstion.dart';
import 'package:zenith/core/extensions/sizes_extensions.dart';
import 'package:zenith/features/home/providers/home_state_provider.dart';
import 'package:zenith/features/expedition/screen/add_expedition_screen.dart';
import 'package:zenith/features/home/screens/buyer_profile_screen.dart';
import 'package:zenith/features/home/screens/explore_screen.dart';
import 'package:zenith/features/home/screens/inbox_screen.dart';
import 'package:zenith/features/home/screens/widgets/app_bars.dart';
import 'package:zenith/features/home/screens/widgets/custom_navigation_bar.dart';
import 'package:zenith/features/home/screens/widgets/popular_houses_card.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  int currentScreen = 0;
  final List<Widget> screens = [
    const HomeScreenWidget(),
    const ExploreScreen(),
    // const FavouriteScreen(),
    const InboxScreen(),
    const BuyerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentScreen = ref.watch(homeStateProvider);
    // final currentUserValue = ref.watch

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.primaryColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: appBars[currentScreen]),
      body: screens[currentScreen],
      bottomNavigationBar: CustomNavigationBar(
        w: context.w,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          context.push(const AddExpeditionScreen());
        },
        child: const Icon(
          Icons.add,
          color: AppColors.backgroundColor,
        ),
      ),
    );
  }
}

class HomeScreenWidget extends ConsumerStatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends ConsumerState<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    // final streamValue = ref.watch(availableRentalHomeStreamProvider);

    return Container(
      height: context.h,
      width: context.w,
      padding: AppPaddings.normal,
      // child: streamValue.when(
      //   error: (error, stackTrace) {
      //     print("error : ${error.toString()} stackTrace: $stackTrace");
      //     return Text("error : ${error.toString()} ",
      //         style: const TextStyle(color: Colors.white));
      //   },
      //   loading: () => const Loader(),
      //   data: (data) => RefreshIndicator(
      //     color: Colors.white,
      //     onRefresh: () async {
      //       return;
      //     },
      child: Column(
        children: [
          Column(children: [
            Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  cursorHeight: 25,
                  controller: TextEditingController(),
                  decoration: AppTextFieldDecorations.searchFieldDecoration,
                )),
            AppSizes.normalY,
            // CatogoriesTabNav(w: context.w),
          ]),
          Container(
            // height: context.h * 0.72,
            // width: context.w,
            // padding: AppPaddings.normal,
            // decoration: const BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(45),
            //         topRight: Radius.circular(45))),
            child: Column(
              children: [
                AppSizes.normalY,
                Row(
                  children: [
                    Text("More of what you like ",
                        style: Theme.of(context).textTheme.headlineMedium),
                    const Spacer(),
                    // const Text("View All"),
                  ],
                ),

                SizedBox(
                  height: context.h * 0.25,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w),
                    itemBuilder: (context, index) => HousesCardWidget(
                        image: "",
                        name: "Centarus",
                        address: "1800 lightyears ",
                        price: "4234234",
                        onTapFav: () {}),
                  ),
                ),
                Row(
                  children: [
                    Text("Recently Played",
                        style: Theme.of(context).textTheme.headlineMedium),
                    const Spacer(),
                    // const Text("View All"),
                  ],
                ),
                Row(
                  children: [
                    Text("Suggested",
                        style: Theme.of(context).textTheme.headlineMedium),
                    const Spacer(),
                    // const Text("View All"),
                  ],
                ),
                AppSizes.normalY,
                // Expanded(
                //   child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: 5,
                //       // data.length,
                //       itemBuilder: (context, index) => Container()
                //       // FeaturedHouseImages(
                //       //   onTap: () {
                //       //     // context.push(
                //       //     //     HouseDetailScreen(house: data[index]));
                //       //   },
                //       //   house: "data[index]",
                //       // )
                //       ),
                // ),
                AppSizes.normalY,
                AppSizes.normalY,
                AppSizes.normalY,
                AppSizes.normalY,
              ],
            ),
          )
        ],
      ),
    );
    // ),
    // )
  }
}
