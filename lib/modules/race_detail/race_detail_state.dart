import 'package:base_bloc/data/model/race_detail_model.dart';
import 'package:base_bloc/data/model/race_model.dart';
import 'package:base_bloc/data/model/tournament_detail_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/round_model.dart';

class RaceDetailState extends Equatable {
  final RaceModel? raceModel;
  final RaceDetailModel? raceDetailModel;
  final bool isLoading;
  final bool refreshUi;

  const RaceDetailState(
      {this.isLoading = true,
      this.raceDetailModel,
      this.raceModel,
      this.refreshUi = false});

  RaceDetailState copyOf(
          {RaceModel? raceModel,
          RaceDetailModel? raceDetailModel,
          TournamentDetailModel? tournamentDetailModel,
          List<RoundModel>? lRound,
          bool? refreshUi,
          bool? isLoading}) =>
      RaceDetailState(
          raceDetailModel: raceDetailModel ?? this.raceDetailModel,
          refreshUi: refreshUi ?? this.refreshUi,
          isLoading: isLoading ?? this.isLoading,
          raceModel: raceModel ?? this.raceModel);

  @override
  List<Object?> get props => [raceModel, raceDetailModel, isLoading, refreshUi];
}
