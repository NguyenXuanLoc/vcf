import 'dart:async';

import 'package:base_bloc/components/dialogs.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/modules/home_page/home_page.dart';
import 'package:base_bloc/modules/person_infomation/person_info_state.dart';
import 'package:base_bloc/modules/update_profile/update_profile_page.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../data/eventbus/refresh_event.dart';
import '../../utils/app_utils.dart';

class PersonInfoBloc extends Cubit<PersonInfoState> {
  StreamSubscription<RefreshEvent>? refreshEvent;

  PersonInfoBloc() : super(PersonInfoState()) {
    getCurrentVersion();
    getUserInfo();
    refreshEvent = Utils.eventBus.on<RefreshEvent>().listen((event) {
      getUserInfo();
    });
  }

  void getUserInfo() async {
    var user = await StorageUtils.getUserInfo();
    emit(state.copyOf(userModel: user, isRefresh: !state.isRefresh));
  }

  void getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyOf(currentVer: packageInfo.version));
  }

  void updateOnClick(BuildContext context) =>
      RouterUtils.pushTo(context, UpdateProfilePage());

  void logoutOnClick(BuildContext context) {
    Dialogs.showCommonDialog(LocaleKeys.do_you_want_to_logout.tr(), context,
        () {
      StorageUtils.logout();
      RouterUtils.pushTo(homeContext, HomePage(), isReplace: true);
    });
  }

  void onDispose() {
    refreshEvent?.cancel();
  }
}
