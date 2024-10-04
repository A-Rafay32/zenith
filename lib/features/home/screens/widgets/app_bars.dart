import 'package:flutter/material.dart';
import 'package:zenith/features/auth/screens/widgets/app_bar_white.dart';
import 'package:zenith/features/home/screens/widgets/home_screen_app_bar.dart';

final List<Widget> appBars = [
  const HomeScreenAppBar(),
  CustomAppBar(
    enableBackButton: false,
    onPressed: () {},
    text: "Explore Space",
  ),
  CustomAppBar(
    enableBackButton: false,
    onPressed: () {},
    text: "Track",
  ),
  CustomAppBar(
    enableBackButton: false,
    onPressed: () {},
    text: "Profile",
  ),
  // CustomAppBar(
  //   enableBackButton: false,
  //   onPressed: () {},
  //   text: "Profile",
  // ),
];
