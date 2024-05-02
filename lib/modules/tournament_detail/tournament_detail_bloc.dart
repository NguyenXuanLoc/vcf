import 'dart:async';
import 'dart:math';

import 'package:base_bloc/data/model/tournament_detail_model.dart';
import 'package:base_bloc/data/model/tournament_model.dart';
import 'package:base_bloc/modules/tournament_detail/tournament_detail_state.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../data/model/round_model.dart';

class TournamentDetailCubit extends Cubit<TournamentDetailState> {
  var pageController = PageController();
  var currentIndex = 0;
  var scrollController = AutoScrollController();

  TournamentDetailCubit(TournamentModel model)
      : super(TournamentDetailState(tournamentModel: model)) {
    getRound();
    pageController.addListener(() {
      var nextPage = pageController.page?.round() ?? 0;
      if (nextPage != currentIndex) {
        state.lRound[currentIndex].isSelect = false;
        state.lRound[nextPage].isSelect = true;
        currentIndex = nextPage;
        scrollController.scrollToIndex(currentIndex);
        emit(state.copyOf(refreshUi: !state.refreshUi));
      }
    });
  }

  void getRound() {
    var list = lRound();
    list.first.isSelect = true;
    Timer(const Duration(seconds: 1),
        () => emit(state.copyOf(isRoundLoading: false, lRound: list)));
  }

  void roundOnClick(int index) {
    state.lRound[currentIndex].isSelect = false;
    state.lRound[index].isSelect = true;
    currentIndex = index;
    emit(state.copyOf(refreshUi: !state.refreshUi));
    pageController.jumpToPage(currentIndex);
    scrollController.scrollToIndex(currentIndex);

  }

  List<RoundModel> lRound() => [
        RoundModel(name: "Vong 1"),
        RoundModel(name: "Vong 2"),
        RoundModel(name: "Vong 3"),
        RoundModel(name: "Vong 4"),
        RoundModel(name: "Vong 5"),
        RoundModel(name: "Vong 6")
      ];
}
