import 'dart:async';

import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/gradient_button.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/modules/splash/splash_cubit.dart';
import 'package:base_bloc/modules/splash/splash_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../gen/assets.gen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashCubit> {
  @override
  void init() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => bloc.openHomePage(context));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        // backgroundColor: colorWhite,
        isFullScreen: true,
        padding: EdgeInsets.zero,
        body: Stack(children: [
          Image.asset(Assets.png.onBoardingBackground.path,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity),
          Center(
              child: Image.asset(Assets.png.icApp.path, height: 90, width: 90))
        ]));
  }

  @override
  SplashCubit createCubit() => SplashCubit();
}
