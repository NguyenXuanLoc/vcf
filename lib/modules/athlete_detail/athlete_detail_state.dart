import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:equatable/equatable.dart';

class AthleteDetailState extends Equatable {
  final bool isAthLoading;
  final AthleteModel? athleteModel;
  final List<AthleteModel> lRelated;
  final bool isRelatedLoading;
  final bool isRelatedReadEnd;

  const AthleteDetailState(
      {this.isAthLoading = false,
      this.isRelatedReadEnd = false,
      this.athleteModel,
      this.lRelated = const [],
      this.isRelatedLoading = false});

  AthleteDetailState copyOf(
          {bool? isAthLoading,
          bool? isRelatedReadEnd,
          bool? isRelatedLoading,
          List<AthleteModel>? lRelated,
          AthleteModel? athleteModel}) =>
      AthleteDetailState(
          isRelatedReadEnd: isRelatedReadEnd ?? this.isRelatedReadEnd,
          athleteModel: athleteModel ?? this.athleteModel,
          isAthLoading: isAthLoading ?? this.isAthLoading,
          isRelatedLoading: isRelatedLoading ?? this.isRelatedLoading,
          lRelated: lRelated ?? this.lRelated);

  @override
  List<Object?> get props => [
        isAthLoading,
        athleteModel,
        lRelated,
        isRelatedLoading,
        isRelatedReadEnd
      ];
}
