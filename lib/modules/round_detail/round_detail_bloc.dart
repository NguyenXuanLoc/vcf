import 'dart:async';
import 'dart:math';

import 'package:base_bloc/data/model/race_detail_model.dart';
import 'package:base_bloc/data/model/round_model.dart';
import 'package:base_bloc/modules/round_detail/round_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/tournament_detail_model.dart';

class RoundDetailBloc extends Cubit<RoundDetailState> {
  final RaceDetailModel model;

  RoundDetailBloc(this.model) : super(RoundDetailState()) {
    emit(state.copyOf(isLoading: false, model: model));
  }
}
