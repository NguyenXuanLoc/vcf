import 'dart:async';

import 'package:base_bloc/data/globals.dart' as globals;
import 'package:base_bloc/modules/home_page/home_page.dart';
import 'package:base_bloc/modules/splash/splash_state.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState()){
  }


  void openHomePage(BuildContext context) async {

    RouterUtils.pushTo(context, HomePage(), isReplace: true);
  }
}
