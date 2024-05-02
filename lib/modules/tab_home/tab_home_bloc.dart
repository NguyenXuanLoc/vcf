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

import '../../data/model/tournament_model.dart';

class TabHomeBloc extends BaseCubit<TabHomeState> {
  TabHomeBloc() : super(const TabHomeState()) {
    getTournament();
    getAthlete();
  }

  void getTournament() {
    Timer(const Duration(seconds: 1),
        () => emit(state.copyOf(isTournamentLoading: false, lTournament: [])));
  }

  void allTournamentObClick() =>
      Utils.fireEvent(JumpToPageEvent(BottomNavigationConstant.TAB_RACE));

  void allAthleteOnClick() =>
      Utils.fireEvent(JumpToPageEvent(BottomNavigationConstant.TAB_ATHLETE));

  void itemTournamentOnClick(TournamentModel model, BuildContext context) {
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

  void getAthlete({bool isPaging = false}) async {
    if (state.isAthleteLoading) return;
    emit(state.copyOf(isAthleteLoading: true));
    try {
      var response = await repository.getAthlete();
      if (response.error == null) {
        var lAthlete = athleteModelFromJson(response.data);
        logE("TAG lAthlete: ${lAthlete.length}");
        emit(state.copyOf(isAthleteLoading: false, lAthlete: lAthlete));
      } else {
        emit(state.copyOf(isAthleteLoading: false));
      }
    } catch (ex) {
      logE("TA lAthlete: $ex");
      emit(state.copyOf(isAthleteLoading: false));
    }
  }

  void onRefresh() {
    emit(const TabHomeState());
    getAthlete();
    getTournament();
  }

}
