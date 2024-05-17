import 'dart:async';

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/data/model/city_model.dart';
import 'package:base_bloc/ext/scroll_controller_ext.dart';
import 'package:base_bloc/modules/tab_race/tab_race_state.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';

import '../../config/constant.dart';
import '../../data/model/race_model.dart';

class TabRaceBloc extends BaseCubit<TabRaceState> {
  var controller = ScrollController();

  TabRaceBloc()
      : super(TabRaceState(
            lRace: List.empty(growable: true),
            lCity: List.empty(growable: true))) {
    getCity();
    getRace();
    controller.paging(() {
      if (!state.isRaceLoading && !state.isReadEnd) {
        getRace(isPaging: true);
      }
    });
  }

  void onRefresh() {
    emit(const TabRaceState());
    getCity();
    getRace();
  }

  void cityOnClick(int index) {
    state.lCity[index].isSelect = !state.lCity[index].isSelect;
    emit(state.copyOf(
        nextPage: 1,
        isReadEnd: false,
        lRace: [],
        isRefreshUI: !state.isRefreshUI,
        isRaceLoading: false));
    getRace();
  }

  void getCity() async {
    if (state.isCityLoading) return;
    emit(state.copyOf(isCityLoading: true));
    try {
      var response = await repository.getCity();
      if (response.error == null) {
        var lCity = cityModelFromJson(response.data);
        emit(state.copyOf(lCity: lCity, isCityLoading: false));
      }
    } catch (ex) {
      emit(state.copyOf(isCityLoading: false));
    }
  }

  void itemTournamentOnClick(RaceModel model, BuildContext context) {
    RouterUtils.pushRace(
        context: context,
        route: RaceRouter.tournamentDetail,
        argument: [model, BottomNavigationConstant.TAB_RACE]);
  }

  void getRace({bool isPaging = false}) async {
    if (state.isRaceLoading) return;
    emit(state.copyOf(isRaceLoading: true));
    try {
      var lCity = state.lCity
          .where((element) => element.isSelect)
          .toList()
          .map((e) => e.id)
          .toList();
      var response = lCity.isEmpty
          ? await repository.getRace(nextPage: state.nextPage)
          : await repository.getRaceFilter(
              nextPage: state.nextPage, ids: lCity);
      if (response.error == null) {
        var lRace = raceModelFromJson(response.data);
        emit(state.copyOf(
            nextPage: state.nextPage + 1,
            isRaceLoading: false,
            lRace: isPaging ? (state.lRace..addAll(lRace)) : lRace,
            isReadEnd: lRace.isEmpty));
      } else {
        emit(state.copyOf(isRaceLoading: false));
      }
    } catch (ex) {
      emit(state.copyOf(isRaceLoading: false));
    }
  }
}
