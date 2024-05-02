import 'dart:async';
import 'dart:math';

import 'package:base_bloc/data/model/round_model.dart';
import 'package:base_bloc/modules/round_detail/round_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/tournament_detail_model.dart';

class RoundDetailBloc extends Cubit<RoundDetailState> {
  final RoundModel model;

  RoundDetailBloc(this.model) : super(RoundDetailState()) {
    getRoundDetail();
  }

  void getRoundDetail() {
    var test = 1000000 + Random().nextInt(1000);
    Timer(
        const Duration(seconds: 1),
        () => emit(state.copyOf(
            isLoading: false,
            model: TournamentDetailModel(
                city: "HA NOI",
                startingPoint: "Hoan Kiem",
                endingPoint: "Ho Tay",
                map: "Cac loai dia hinh khac nhau",
                distance: 20,
                waterFree: "Cicile K",
                totalNumber: 100,
                cost: test,
                donors: "AWS"))));
  }
}
