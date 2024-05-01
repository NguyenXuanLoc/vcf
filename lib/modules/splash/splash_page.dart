import 'dart:async';

import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/modules/splash/splash_cubit.dart';
import 'package:base_bloc/modules/splash/splash_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return AppScaffold(body: Center(child: AppText("TAG SPLASH")));
  }

  @override
  SplashCubit createCubit() => SplashCubit();
}
