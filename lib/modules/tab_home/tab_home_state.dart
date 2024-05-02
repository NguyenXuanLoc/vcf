import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/tournament_model.dart';

class TabHomeState extends Equatable {
  final bool isTournamentLoading;
  final List<TournamentModel> lTournament;
  final bool isAthleteLoading;
  final List<AthleteModel> lAthlete;

  const TabHomeState(
      {this.isTournamentLoading = true,
      this.lTournament = const [],
      this.isAthleteLoading = false,
      this.lAthlete = const []});

  TabHomeState copyOf(
          {bool? isAthleteLoading,
          List<AthleteModel>? lAthlete,
          bool? isTournamentLoading,
          List<TournamentModel>? lTournament}) =>
      TabHomeState(
          isAthleteLoading: isAthleteLoading ?? this.isAthleteLoading,
          lAthlete: lAthlete ?? this.lAthlete,
          isTournamentLoading: isTournamentLoading ?? this.isTournamentLoading,
          lTournament: lTournament ?? this.lTournament);

  @override
  List<Object?> get props =>
      [isTournamentLoading, lTournament, isAthleteLoading, lAthlete];
}
