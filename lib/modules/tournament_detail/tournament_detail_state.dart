import 'package:base_bloc/data/model/tournament_detail_model.dart';
import 'package:base_bloc/data/model/tournament_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/round_model.dart';

class TournamentDetailState extends Equatable {
  final TournamentModel? tournamentModel;
  final List<RoundModel> lRound;
  final bool isRoundLoading;
  final bool refreshUi;

  const TournamentDetailState(
      {this.isRoundLoading = true,
      this.tournamentModel,
      this.refreshUi = false,
      this.lRound = const []});

  TournamentDetailState copyOf(
          {TournamentModel? tournamentModel,
          TournamentDetailModel? tournamentDetailModel,
          List<RoundModel>? lRound,
          bool? refreshUi,
          bool? isRoundLoading}) =>
      TournamentDetailState(
          refreshUi: refreshUi ?? this.refreshUi,
          isRoundLoading: isRoundLoading ?? this.isRoundLoading,
          lRound: lRound ?? this.lRound,
          tournamentModel: tournamentModel ?? this.tournamentModel);

  @override
  List<Object?> get props =>
      [tournamentModel, lRound, isRoundLoading, refreshUi];
}
