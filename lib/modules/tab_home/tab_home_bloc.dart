import 'dart:async';

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/eventbus/jump_to_page_event.dart';
import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:base_bloc/modules/tab_home/tab_home_state.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';

import '../../data/model/race_model.dart';

class TabHomeBloc extends BaseCubit<TabHomeState> {
  TabHomeBloc() : super(const TabHomeState()) {
    getRace();
    getAthlete();
  }


  void allRaceOnClick() =>
      Utils.fireEvent(JumpToPageEvent(BottomNavigationConstant.TAB_RACE));

  void allAthleteOnClick() =>
      Utils.fireEvent(JumpToPageEvent(BottomNavigationConstant.TAB_ATHLETE));

  void itemTournamentOnClick(RaceModel model, BuildContext context) {
    RouterUtils.pushHome(
        context: context,
        route: HomeRouter.tournamentDetail,
        argument: [model, BottomNavigationConstant.TAB_HOME]);
  }

  void itemAthleteOnClick(AthleteModel model, BuildContext context) {
    RouterUtils.pushHome(
        context: context,
        route: HomeRouter.athleteDetail,
        argument: [model, BottomNavigationConstant.TAB_HOME]);
  }

  void getRace({bool isPaging = false}) async {
    if (state.isRaceLoading) return;
    emit(state.copyOf(isRaceLoading: true));
    try {
      var response = await repository.getRace();
      if (response.error == null) {
        var lRace = raceModelFromJson(response.data);
        emit(state.copyOf(isRaceLoading: false, lRace: lRace));
      } else {
        emit(state.copyOf(isRaceLoading: false));
      }
    } catch (ex) {
      emit(state.copyOf(isRaceLoading: false));
    }
  }

  void getAthlete({bool isPaging = false}) async {
    if (state.isAthleteLoading) return;
    emit(state.copyOf(isAthleteLoading: true));
    try {
      var response = await repository.getAthlete();
      if (response.error == null) {
        var lAthlete = athleteModelFromJson(response.data);
        emit(state.copyOf(isAthleteLoading: false, lAthlete: lAthlete));
      } else {
        emit(state.copyOf(isAthleteLoading: false));
      }
    } catch (ex) {
      emit(state.copyOf(isAthleteLoading: false));
    }
  }

  void onRefresh() {
    emit(const TabHomeState());
    getAthlete();
    getRace();
  }
}
