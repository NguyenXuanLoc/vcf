import 'dart:async';

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/data/model/athlete_detail_model.dart';
import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:base_bloc/modules/athlete_detail/athlete_detail_state.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';

import '../../router/router.dart';
import '../../router/router_utils.dart';

class AthleteDetailBloc extends BaseCubit<AthleteDetailState> {
  var controller = ScrollController();
  final AthleteModel model;

  AthleteDetailBloc(this.model) : super(AthleteDetailState()) {
    state.athleteModel = model;
    controller.addListener(() {
      if (!state.isRelatedLoading &&
          !state.isRelatedReadEnd &&
          state.lRelated.isNotEmpty) {
        getRelatedAthlete(isPaging: true);
      }
    });
    getAthlete(model);
  }

  void onRefresh() {
    emit(AthleteDetailState(athleteModel: model));
    getAthlete(model);
  }

  void itemOnClick(AthleteModel model, int root, BuildContext context) {
    RouterUtils.pushHome(
        context: context,
        route: HomeRouter.athleteDetail,
        argument: [model, root]);
  }

  void getAthlete(AthleteModel model) async {
    emit(state.copyOf(isAthLoading: true));
    try {
      var response =
          await repository.getAthleteDetailById(state.athleteModel?.id ?? 0);
      if (response.error == null) {
        var model = AthleteDetailModel.fromJson(response.data);
        emit(state.copyOf(athleteDetailModel: model, isAthLoading: false));
        getRelatedAthlete();
      }
    } catch (ex) {
      emit(state.copyOf(isAthLoading: false));
    }
  }

  void getRelatedAthlete({bool isPaging = false}) async {
    if (state.isRelatedLoading || state.isRelatedReadEnd) return;
    emit(state.copyOf(isRelatedLoading: true));
    try {
      var response = await repository.getAthlete(nextPage: state.nextPage);
      if (response.error == null) {
        var lAthlete = athleteModelFromJson(response.data)
            .where((element) => element.id != state.athleteModel?.id)
            .toList();
        emit(state.copyOf(
            nextPage: state.nextPage + 1,
            isRelatedReadEnd: lAthlete.isEmpty,
            isRelatedLoading: false,
            lRelated:
                isPaging ? (state.lRelated..addAll(lAthlete)) : lAthlete));
      } else {
        emit(state.copyOf(isAthLoading: false));
      }
    } catch (ex) {
      emit(state.copyOf(isAthLoading: false));
    }
  }

  List<AthleteModel> fakeAth() => [];
}
