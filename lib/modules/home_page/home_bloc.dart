import 'dart:async';

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/modules/home_page/home_state.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../config/constant.dart';
import '../../data/eventbus/jump_to_page_event.dart';
import '../../data/globals.dart' as globals;
import '../../service/firebase_service.dart';

class HomeBloc extends BaseCubit<HomeState> {
  late StreamSubscription<JumpToPageEvent> jumpToPageStream;
  var pageController = PageController();
  BuildContext? context;
  var currentIndex = 0;
  StreamSubscription<ConnectivityResult>? internetConnectionStream;
  final navigatorKeys = {
    BottomNavigationConstant.TAB_HOME: GlobalKey<NavigatorState>(),
    BottomNavigationConstant.TAB_RACE: GlobalKey<NavigatorState>(),
    BottomNavigationConstant.TAB_ATHLETE: GlobalKey<NavigatorState>(),
    BottomNavigationConstant.TAB_PROFILE: GlobalKey<NavigatorState>(),
  };

  HomeBloc() : super(const HomeState()) {
    FirebaseService().init();
    jumpToPageStream = Utils.eventBus
        .on<JumpToPageEvent>()
        .listen((event) => jumpToPage(event.page, context));
    getUserInfo();
  }

  void getUserInfo() async {
    if (globals.isLogin && globals.userModel == null) {
      await Utils.getUserInfo();
      emit(state.copyOf(isRefreshUi: !state.isRefreshUi));
    }
  }

  void init() {}

  Future<bool> onWillPop() async {
    final isFirstRouteInCurrentTab =
        !await navigatorKeys[currentIndex]!.currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      jumpToPage(currentIndex, context);
      // return false;
    }
    return isFirstRouteInCurrentTab;
  }

  void setContext(BuildContext context) {
    globals.homeContext = context;
    this.context = context;
  }

  void jumpToPage(int index, BuildContext? context) async {
    if (index == currentIndex) {
      navigatorKeys[currentIndex]!.currentState!.maybePop();
    } else {
      currentIndex = index;
      pageController.jumpToPage(index);
      emit(state.copyOf(index: index));
    }
  }
}
