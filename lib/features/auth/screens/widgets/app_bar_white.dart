import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar(
      {super.key,
      this.backgroundColor = Colors.white,
      this.textColors = Colors.black,
      this.enableBackButton = true,
      required this.onPressed,
      required this.text});

  final String text;
  bool enableBackButton;
  final Function() onPressed;
  final Color backgroundColor;
  final Color textColors;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        text,
        style: TextStyle(color: textColors, fontSize: 21),
      ),
      actions: const [],
      leading: enableBackButton
          ? CupertinoNavigationBarBackButton(
              color: textColors, onPressed: onPressed)
          : null,
    );
  }
}
