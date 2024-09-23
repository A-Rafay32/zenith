import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zenith/app/themes/app_paddings.dart';
import 'package:zenith/app/themes/app_text_field_themes.dart';
import 'package:zenith/core/extensions/routes_extenstion.dart';
import 'package:zenith/core/extensions/sizes_extensions.dart';
import 'package:zenith/features/auth/screens/widgets/app_bar_white.dart';
import 'package:zenith/features/auth/screens/widgets/button.dart';
import 'package:zenith/features/auth/screens/widgets/custom_text_field.dart';
import 'package:zenith/features/auth/screens/widgets/header.dart';
import 'package:zenith/features/auth/screens/widgets/signup_bar.dart';
import 'package:zenith/features/home/screens/home_screen.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(54),
          child: CustomAppBar(
            onPressed: () {
              context.pop();
            },
            text: "Recover",
          ),
        ),
        body: SafeArea(
            child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              LoginHeader(
                w: context.w,
                text1: "Recover Password",
                text2: "Provide either your email or phone Number",
                text3: "",
              ),
              AppSizes.largeY,
              AppSizes.largeY,
              CustomTextField(
                  validator: (value) {
                    return value == null ? "Field can't be empty" : null;
                  },
                  controller: TextEditingController(),
                  inputDecoration:
                      AppTextFieldDecorations.emailInputDecoration),
              AppSizes.largeY,
              Button(
                press: () {
                  context.push(HomeScreen());
                },
                text: "Submit",
              ),
              const Spacer(),
              SignUpBar(
                onTap: () => context.pop(),
                text1: "Already rememeber password?",
                text2: "Sign in",
              ),
            ],
          ),
        )));
  }
}
