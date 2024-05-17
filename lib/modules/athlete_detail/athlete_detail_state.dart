import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/athlete_detail_model.dart';

class AthleteDetailState extends Equatable {
  final bool isAthLoading;
  AthleteModel? athleteModel;
  AthleteDetailModel? athleteDetailModel;
  final List<AthleteModel> lRelated;
  final bool isRelatedLoading;
  final bool isRelatedReadEnd;
  final int nextPage;

  AthleteDetailState(
      {this.isAthLoading = false,
      this.isRelatedReadEnd = false,
      this.athleteModel,
      this.nextPage = 1,
      this.athleteDetailModel,
      this.lRelated = const [],
      this.isRelatedLoading = false});

  AthleteDetailState copyOf(
          {bool? isAthLoading,
          int? nextPage,
          bool? isRelatedReadEnd,
          bool? isRelatedLoading,
          List<AthleteModel>? lRelated,
          AthleteDetailModel? athleteDetailModel,
          AthleteModel? athleteModel}) =>
      AthleteDetailState(
          nextPage: nextPage ?? this.nextPage,
          athleteDetailModel: athleteDetailModel ?? this.athleteDetailModel,
          isRelatedReadEnd: isRelatedReadEnd ?? this.isRelatedReadEnd,
          athleteModel: athleteModel ?? this.athleteModel,
          isAthLoading: isAthLoading ?? this.isAthLoading,
          isRelatedLoading: isRelatedLoading ?? this.isRelatedLoading,
          lRelated: lRelated ?? this.lRelated);

  @override
  List<Object?> get props => [
        nextPage,
        isAthLoading,
        athleteDetailModel,
        athleteModel,
        lRelated,
        isRelatedLoading,
        isRelatedReadEnd
      ];
}
