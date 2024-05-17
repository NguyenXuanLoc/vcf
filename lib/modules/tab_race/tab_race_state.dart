import 'package:base_bloc/data/model/race_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/city_model.dart';

class TabRaceState extends Equatable {
  final bool isCityLoading;
  final bool isRaceLoading;
  final bool isReadEnd;
  final bool isRefreshUI;
  final List<CityModel> lCity;
  final List<RaceModel> lRace;
  final int nextPage;

  const TabRaceState(
      {this.isCityLoading = false,
      this.nextPage = 1,
      this.isRaceLoading = false,
      this.isReadEnd = false,
      this.lRace = const [],
      this.lCity = const [],
      this.isRefreshUI = false});

  TabRaceState refreshUI() => copyOf(isRefreshUI: !isRefreshUI);

  TabRaceState copyOf(
          {bool? isCityLoading,
          int? nextPage,
          List<CityModel>? lCity,
          bool? isRaceLoading,
          bool? isReadEnd,
          bool? isRefreshUI,
          List<RaceModel>? lRace}) =>
      TabRaceState(
          nextPage: nextPage ?? this.nextPage,
          lRace: lRace ?? this.lRace,
          isRaceLoading: isRaceLoading ?? this.isRaceLoading,
          isReadEnd: isReadEnd ?? this.isReadEnd,
          isRefreshUI: isRefreshUI ?? this.isRefreshUI,
          isCityLoading: isCityLoading ?? this.isCityLoading,
          lCity: lCity ?? this.lCity);

  @override
  List<Object?> get props => [
        isCityLoading,
        lCity,
        isRefreshUI,
        lRace,
        isRaceLoading,
        isReadEnd,
        nextPage
      ];
}
