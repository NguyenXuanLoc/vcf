import 'dart:async';

import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:base_bloc/modules/athlete_detail/athlete_detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/constant.dart';
import '../../router/router.dart';
import '../../router/router_utils.dart';

class AthleteDetailBloc extends Cubit<AthleteDetailState> {
  var controller = ScrollController();
  final AthleteModel model;

  AthleteDetailBloc(this.model) : super(AthleteDetailState()) {
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
    emit(const AthleteDetailState());
    getAthlete(model);
  }

  void itemOnClick(AthleteModel model, int root, BuildContext context) {
    RouterUtils.pushHome(
        context: context,
        route: HomeRouter.athleteDetail,
        argument: [model, root]);
  }

  void getAthlete(AthleteModel model) {
    emit(state.copyOf(isAthLoading: true));
    Timer(const Duration(seconds: 1), () {
      emit(state.copyOf(athleteModel: model, isAthLoading: false));
      getRelatedAthlete();
    });
  }

  void getRelatedAthlete({bool isPaging = false}) {
    if (state.isRelatedLoading || state.isRelatedReadEnd) return;
    emit(state.copyOf(isRelatedLoading: true));
    Timer(
        const Duration(seconds: 1),
        () => emit(state.copyOf(
            isRelatedLoading: false,
            isRelatedReadEnd: state.lRelated.length > 20,
            lRelated: !isPaging
                ? fakeAth().toList(growable: true)
                : (state.lRelated..addAll(fakeAth())))));
  }

  List<AthleteModel> fakeAth() => [];
}
