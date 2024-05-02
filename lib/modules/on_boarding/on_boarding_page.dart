import 'dart:async';

import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/gradient_button.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../gen/assets.gen.dart';
import 'on_boarding_bloc.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends BaseState<OnBoardingPage, OnBoardingBloc> {
  @override
  void init() {}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        isFullScreen: true,
        padding: EdgeInsets.zero,
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(Assets.png.onBoardingBackground.path,
                    gaplessPlayback: true, fit: BoxFit.cover)),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                  left: contentPadding, right: contentPadding, bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(Assets.png.icApp.path, height: 75, width: 74),
                  space(height: 10),
                  AppText(LocaleKeys.onboarding_title.tr(),
                      style: typoW600.copyWith(fontSize: 18, color: colorWhite),
                      textAlign: TextAlign.center),
                  space(height: 40),
                  loginButton,
                  space(),
                  Text.rich(TextSpan(
                      text: "${LocaleKeys.Do_you_have_not_an_account.tr()} ",
                      style: typoW500.copyWith(fontSize: 12, color: colorWhite),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>bloc.registerOnClick(context),
                            text: LocaleKeys.register_new.tr(),
                            style: typoW500.copyWith(
                                fontSize: 12, color: HexColor('0093DD')))
                      ]))
                ],
              ),
            ),
          ],
        ));
  }

  Widget get loginButton => GradientButton(
      width: MediaQuery.of(context).size.width,
      onTap: () =>bloc.loginOnClick(context),
      isCenter: true,
      widget: AppText(LocaleKeys.Login.tr(),
          style: typoW700.copyWith(fontSize: 16, color: colorWhite)));

  Widget space({double? height}) => SizedBox(height: height ?? 25);

  @override
  OnBoardingBloc createCubit() => OnBoardingBloc();
}
