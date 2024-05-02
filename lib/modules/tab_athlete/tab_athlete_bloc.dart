import 'dart:async';

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/ext/scroll_controller_ext.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/modules/tab_athlete/tab_athlete_state.dart';
import 'package:base_bloc/router/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../data/model/athlete_model.dart';
import '../../router/router_utils.dart';

class TabAthleteBloc extends BaseCubit<TabAthleteState> {
  var controller = ScrollController();

  TabAthleteBloc() : super(const TabAthleteState()) {
    getMale();
    getAthlete();
    controller.paging(() {
      if (!state.isLoading && !state.isReadEnd) {
        getAthlete(isPaging: true);
      }
    });
  }

  void getMale() {
    emit(state.copyOf(mMale: mMale, male: mMale.keys.first));
  }

  void filterOnClick(String value) {
    emit(state
        .copyOf(male: value, isLoading: false, isReadEnd: false, lAth: []));
    getAthlete();
  }

  void onRefresh() {
    emit(const TabAthleteState());
    getMale();
    getAthlete();
  }

  void itemOnClick(AthleteModel model, BuildContext context) {
    RouterUtils.pushAthlete(
        context: context,
        route: AthleteRouter.athleteDetail,
        argument: [model, BottomNavigationConstant.TAB_ATHLETE]);
  }

  void getAthlete({bool isPaging = false}) async {
    if (state.isLoading || state.isReadEnd) return;
    emit(state.copyOf(isLoading: true));
    try {
      var response = await repository.getAthleteFilter(
          nextPage: state.nextPage, gender: state.mMale[state.male] ?? '');
      if (response.error == null) {
        var lAthlete = athleteModelFromJson(response.data);
        emit(state.copyOf(
            isReadEnd: lAthlete.isEmpty,
            isLoading: false,
            lAth: isPaging ? (state.lAth..addAll(lAthlete)) : lAthlete));
      } else {
        emit(state.copyOf(isLoading: false));
      }
    } catch (ex) {
      emit(state.copyOf(isLoading: false, isReadEnd: true));
    }
  }

  Map<String, String> get mMale => {
        LocaleKeys.All.tr(): ApiKey.other,
        LocaleKeys.Male.tr(): ApiKey.male,
        LocaleKeys.FeMale.tr(): ApiKey.female,
      };
}
