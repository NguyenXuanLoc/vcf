import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/race_model.dart';

class TabHomeState extends Equatable {
  final bool isRaceLoading;
  final List<RaceModel> lRace;
  final bool isAthleteLoading;
  final List<AthleteModel> lAthlete;

  const TabHomeState(
      {this.isRaceLoading = false,
      this.lRace = const [],
      this.isAthleteLoading = false,
      this.lAthlete = const []});

  TabHomeState copyOf(
          {bool? isAthleteLoading,
          List<AthleteModel>? lAthlete,
          bool? isRaceLoading,
          List<RaceModel>? lRace}) =>
      TabHomeState(
          isAthleteLoading: isAthleteLoading ?? this.isAthleteLoading,
          lAthlete: lAthlete ?? this.lAthlete,
          isRaceLoading: isRaceLoading ?? this.isRaceLoading,
          lRace: lRace ?? this.lRace);

  @override
  List<Object?> get props => [isRaceLoading, lRace, isAthleteLoading, lAthlete];
}
