import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenith/app/constants/app_images.dart';
import 'package:zenith/core/extensions/text_theme_ext.dart';
import 'package:zenith/features/auth/screens/auth_builder.dart';
import 'dart:async';

import 'package:zenith/features/home/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => AuthStateBuilder(widget: HomeScreen())),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.splashImage2,
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              'Zenith',
              style: context.textTheme.headlineLarge?.copyWith(fontSize: 40.sp),
              // style: TextStyle(
              //   fontSize: 36.0,
              //   color: Colors.white,
              //   fontWeight: FontWeight.bold,
              //   shadows: [
              //     Shadow(
              //       blurRadius: 10.0,
              //       color: Colors.black,
              //       offset: Offset(3.0, 3.0),
              //     ),
              //   ],
              // ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
