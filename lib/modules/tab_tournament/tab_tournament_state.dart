import 'package:base_bloc/data/model/tournament_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/city_model.dart';

class TabTournamentState extends Equatable {
  final bool isCityLoading;
  final bool isNewsLoading;
  final bool isReadEnd;
  final bool isRefreshUI;
  final List<CityModel> lCity;
  final List<TournamentModel> lNews;

  const TabTournamentState(
      {this.isCityLoading = true,
      this.isNewsLoading = false,
      this.isReadEnd = false,
      this.lNews = const [],
      this.lCity = const [],
      this.isRefreshUI = false});

  TabTournamentState refreshUI() => TabTournamentState(
      isNewsLoading: isNewsLoading,
      isReadEnd: isReadEnd,
      lNews: lNews,
      isRefreshUI: !isRefreshUI,
      isCityLoading: isCityLoading,
      lCity: lCity);

  TabTournamentState copyOf(
          {bool? isCityLoading,
          List<CityModel>? lCity,
          bool? isNewsLoading,
          bool? isReadEnd,
          bool? isRefreshUI,
          List<TournamentModel>? lNews}) =>
      TabTournamentState(
          lNews: lNews ?? this.lNews,
          isNewsLoading: isNewsLoading ?? this.isNewsLoading,
          isReadEnd: isReadEnd ?? this.isReadEnd,
          isRefreshUI: isRefreshUI ?? this.isRefreshUI,
          isCityLoading: isCityLoading ?? this.isCityLoading,
          lCity: lCity ?? this.lCity);

  @override
  List<Object?> get props =>
      [isCityLoading, lCity, isRefreshUI, lNews, isNewsLoading, isReadEnd];
}
