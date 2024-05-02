import 'package:equatable/equatable.dart';

import '../../data/model/athlete_model.dart';

class TabAthleteState extends Equatable {
  final Map<String, String> mMale;
  final String male;
  final bool isReadEnd;
  final bool isLoading;
  final List<AthleteModel> lAth;
  final int nextPage;

  const TabAthleteState(
      {this.mMale = const {},
      this.nextPage = 1,
      this.male = '',
      this.isReadEnd = false,
      this.isLoading = false,
      this.lAth = const []});

  TabAthleteState copyOf(
          {Map<String, String>? mMale,
          int? nextPage,
          String? male,
          bool? isLoading,
          bool? isReadEnd,
          List<AthleteModel>? lAth}) =>
      TabAthleteState(
          nextPage: nextPage ?? this.nextPage,
          isLoading: isLoading ?? this.isLoading,
          isReadEnd: isReadEnd ?? this.isReadEnd,
          lAth: lAth ?? this.lAth,
          mMale: mMale ?? this.mMale,
          male: male ?? this.male);

  @override
  List<Object?> get props =>
      [nextPage, mMale, male, isLoading, isReadEnd, lAth];
}
