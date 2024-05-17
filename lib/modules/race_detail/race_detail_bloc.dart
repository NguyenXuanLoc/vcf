import 'dart:async';

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/data/model/race_detail_model.dart';
import 'package:base_bloc/data/model/race_model.dart';
import 'package:base_bloc/modules/race_detail/race_detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../data/model/round_model.dart';

class RaceDetailCubit extends BaseCubit<RaceDetailState> {
  var pageController = PageController();
  var currentIndex = 0;
  var scrollController = AutoScrollController();

  RaceDetailCubit(RaceModel model) : super(RaceDetailState(raceModel: model)) {
    getRaceDetail();
    pageController.addListener(() {
      var nextPage = pageController.page?.round() ?? 0;
      if (nextPage != currentIndex) {
        state.raceDetailModel?.rounds?[currentIndex].isSelect = false;
        state.raceDetailModel?.rounds?[nextPage].isSelect = true;
        currentIndex = nextPage;
        scrollController.scrollToIndex(currentIndex);
        emit(state.copyOf(refreshUi: !state.refreshUi));
      }
    });
  }

  void getRaceDetail() async {
    emit(state.copyOf(isLoading: true));
    try {
      var response =
          await repository.getRaceDetailById(state.raceModel?.id ?? 0);
      if (response.error == null) {
        var raceDetailModel = RaceDetailModel.fromJson(response.data);
        if (raceDetailModel.rounds != null &&
            raceDetailModel.rounds!.isNotEmpty) {
          raceDetailModel.rounds?.first.isSelect = true;
        } else {
          raceDetailModel.rounds?.add(raceDetailModel);
          raceDetailModel.rounds?.first.isSelect = true;
        }
        emit(state.copyOf(raceDetailModel: raceDetailModel, isLoading: false));
      }
    } catch (ex) {
      emit(state.copyOf(isLoading: false));
    }
  }

  void roundOnClick(int index) {
    state.raceDetailModel?.rounds?[currentIndex].isSelect = false;
    state.raceDetailModel?.rounds?[index].isSelect = true;
    currentIndex = index;
    emit(state.copyOf(refreshUi: !state.refreshUi));
    pageController.jumpToPage(currentIndex);
    scrollController.scrollToIndex(currentIndex);
  }
}
