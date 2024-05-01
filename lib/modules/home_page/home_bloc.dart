import 'dart:async';

import 'package:base_bloc/base/base_cubit.dart';

import 'package:base_bloc/modules/home_page/home_state.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../data/eventbus/jump_to_page_event.dart';
import '../../data/eventbus/switch_tab_event.dart';
import '../../data/globals.dart' as globals;
import '../../service/firebase_service.dart';

class HomeBloc extends BaseCubit<HomeState> {
  late StreamSubscription<JumpToPageEvent> jumpToPageStream;
  var pageController = PageController();
  BuildContext? context;
  var currentIndex = 0;
  StreamSubscription<ConnectivityResult>? internetConnectionStream;

  HomeBloc() : super(const HomeState()) {
    FirebaseService().init();
  }

  void init() {}

  void setContext(BuildContext context) {
    globals.homeContext = context;
    this.context = context;
  }

  void jumpToPage(int index, BuildContext? context) async {
    if (index == currentIndex) {
      Utils.fireEvent(SwitchTabEvent(index));
    }
    currentIndex = index;
    pageController.jumpToPage(index);
    emit(state.copyOf(index: index));
  }
}
