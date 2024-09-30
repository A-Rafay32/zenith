import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/app/themes/app_colors.dart';
import 'package:zenith/core/extensions/routes_extenstion.dart';
import 'package:zenith/features/home/screens/notification_screen.dart';

class HomeScreenAppBar extends ConsumerWidget {
  const HomeScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // String? userName = FirebaseAuth.instance.currentUser?.displayName;

    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      centerTitle: false,
      leading: const Padding(
        padding: EdgeInsets.only(left: 5, top: 5, bottom: 8),
        child: CircleAvatar(
          backgroundColor: Colors.green,
          backgroundImage: AssetImage("assets/svgs/profile/user_avatar.png"),
          radius: 3,
        ),
      ),
      title: Column(
        children: [
          Text(
            "Hi, userName",
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
          ),
          Text(
            "London, UK",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            context.push(const NotificationScreen());
          },
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(5)),
              backgroundColor:
                  MaterialStatePropertyAll(AppColors.blackshadowColor),
              elevation: MaterialStatePropertyAll(10.0),
              shape: MaterialStatePropertyAll(CircleBorder())),
          child: const Icon(
            Icons.notifications_none_outlined,
            size: 25,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
